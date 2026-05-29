import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_providers.dart';
import '../providers/order_provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _telController = TextEditingController();
  final _adresseController = TextEditingController();
  final _villeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Finaliser la commande")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Formulaire [cite: 29]
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: "Nom complet"),
                validator: (v) => v!.isEmpty ? "Obligatoire" : null, // [cite: 30]
              ),
              TextFormField(
                controller: _telController,
                decoration: const InputDecoration(labelText: "Téléphone"),
                keyboardType: TextInputType.number, // [cite: 30]
                validator: (v) => (v == null || v.isEmpty) ? "Obligatoire" : null,
              ),
              TextFormField(
                controller: _adresseController,
                decoration: const InputDecoration(labelText: "Adresse"),
                validator: (v) => v!.isEmpty ? "Obligatoire" : null,
              ),
              TextFormField(
                controller: _villeController,
                decoration: const InputDecoration(labelText: "Ville"),
                validator: (v) => v!.isEmpty ? "Obligatoire" : null,
              ),

              const Divider(height: 40),
              const Text("Récapitulatif", style: TextStyle(fontWeight: FontWeight.bold)), // [cite: 31]

              // Liste en lecture seule [cite: 31]
              ...cartProvider.items.map((item) => ListTile(
                title: Text(item.title),
                trailing: Text("x${item.quantity}"),
              )).toList(),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Sauvegarde, vide le panier et redirige [cite: 32]
                    await Provider.of<OrderProvider>(context, listen: false)
                        .confirmOrder(cartProvider.items, cartProvider.totalAmount);
                    cartProvider.clearCart();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderScreen()));
                  }
                },
                child: const Text("Confirmer"), // [cite: 32]
              ),
            ],
          ),
        ),
      ),
    );
  }
}