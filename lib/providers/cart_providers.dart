import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import '../model/cart_item.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  Database? _database;

  List<CartItem> get items => _items;

  CartProvider() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'cart_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cart(id INTEGER PRIMARY KEY, title TEXT, price REAL, image TEXT, quantity INTEGER)',
        );
      },
      version: 1,
    );
    await loadItems();
  }

  Future<void> loadItems() async {
    final List<Map<String, dynamic>> maps = await _database!.query('cart');
    _items = List.generate(maps.length, (i) => CartItem.fromMap(maps[i]));
    notifyListeners();
  }

  Future<void> addItem(CartItem item) async {
    final existingIndex = _items.indexWhere((element) => element.id == item.id);
    if (existingIndex >= 0) {
      await updateQuantity(item.id, _items[existingIndex].quantity + item.quantity);
    } else {
      await _database!.insert('cart', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      await loadItems();
    }
  }

  Future<void> updateQuantity(int id, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeItem(id);
    } else {
      await _database!.update(
        'cart',
        {'quantity': newQuantity},
        where: 'id = ?',
        whereArgs: [id],
      );
      await loadItems();
    }
  }

  Future<void> removeItem(int id) async {
    await _database!.delete('cart', where: 'id = ?', whereArgs: [id]);
    await loadItems();
  }

  Future<void> clearCart() async {
    await _database!.delete('cart');
    _items = [];
    notifyListeners();
  }

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  String formatPrice(double price) {
    return NumberFormat.currency(locale: 'fr_FR', symbol: '€').format(price);
  }
}