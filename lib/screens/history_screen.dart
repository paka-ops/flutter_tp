import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context).orders; // Lu depuis sqflite [cite: 32]

    if (orders.isEmpty) {
      return const Center(child: Text("Aucune commande pour le moment")); // [cite: 36]
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Mes Commandes")),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text("Commande n°${order.id}"), // [cite: 35]
            subtitle: Text("${order.date} - ${order.itemCount} articles"), // [cite: 35]
            trailing: Text("${order.total} €"), // [cite: 35]
            onTap: () {
              // Afficher le détail [cite: 35]
            },
          );
        },
      ),
    );
  }
}