import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

import '../model/cart_item.dart';
import '../model/order_item.dart';


class OrderProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  Database? _database;

  List<OrderItem> get orders => _orders;

  OrderProvider() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'orders_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE orders(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, itemCount INTEGER, total REAL, productsJson TEXT)',
        );
      },
      version: 1,
    );
    await loadOrders();
  }

  Future<void> loadOrders() async {
    if (_database == null) await _initDatabase();
    // Tri de la plus récente à la plus ancienne (DESC)
    final List<Map<String, dynamic>> maps = await _database!.query('orders', orderBy: 'id DESC');
    _orders = List.generate(maps.length, (i) => OrderItem.fromMap(maps[i]));
    notifyListeners();
  }

  Future<void> confirmOrder(List<CartItem> cartProducts, double totalAmount) async {
    final String dateString = DateTime.now().toString().split('.')[0];

    // Convertir la liste des produits du panier en JSON pour la lecture seule plus tard
    final List<Map<String, dynamic>> productsMap = cartProducts.map((e) => e.toMap()).toList();
    final String productsJson = json.encode(productsMap);

    final newOrder = OrderItem(
      date: dateString,
      itemCount: cartProducts.length,
      total: totalAmount,
      productsJson: productsJson,
    );

    await _database!.insert('orders', newOrder.toMap());
    await loadOrders();
  }

  Future<void> clearHistory() async {
    await _database!.delete('orders');
    _orders = [];
    notifyListeners();
  }
}