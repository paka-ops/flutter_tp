import 'package:ecommerce_app/providers/cart_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER BRUTALISTE ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2F163), // Jaune cyber
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "MON_PANIER",
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w900, // Corrigé ici
                        fontSize: 22,
                        color: Colors.black,
                        letterSpacing: -1,
                      ),
                    ),
                    Text(
                      "[ ${cartItems.length} ]",
                      style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

            // --- CORPS / LISTE DES ARTICLES ---
            Expanded(
              child: cartItems.isEmpty
                  ? Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    color: Colors.white,
                  ),
                  child: const Text(
                    "AUCUN ARTICLE DÉTECTÉ",
                    style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold),
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: cartItems.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  final subtotal = item.price * item.quantity;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 3),
                      boxShadow: const [
                        BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              color: Colors.grey[50],
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Image.network(item.image, fit: BoxFit.contain),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: -0.5), // Corrigé ici
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "PRIX: ${item.price.toStringAsFixed(2)} €",
                                  style: TextStyle(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "TOTAL: ${subtotal.toStringAsFixed(2)} €",
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 13), // Corrigé ici
                                ),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              _brutalBtn(Icons.add, () => cartProvider.updateQuantity(item.id, item.quantity + 1)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  "${item.quantity}",
                                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15), // Corrigé ici
                                ),
                              ),
                              _brutalBtn(Icons.remove, () => cartProvider.updateQuantity(item.id, item.quantity - 1)),
                            ],
                          ),
                          const SizedBox(width: 8),

                          InkWell(
                            onTap: () => cartProvider.removeItem(item.id),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF6B6B),
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: const Icon(Icons.delete_outline, color: Colors.black, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // --- FOOTER / TOTAL DE LA COMMANDE ---
            if (cartItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("TOTAL GÉNÉRAL", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14)), // Corrigé ici
                          Text(
                            "${cartProvider.totalAmount.toStringAsFixed(2)} €",
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black), // Corrigé ici
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderScreen()));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: const [
                            BoxShadow(color: Color(0xFFE2F163), offset: Offset(-4, 4)),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "PASSER LA COMMANDE →",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900, // Corrigé ici
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _brutalBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Icon(icon, size: 16, color: Colors.black),
      ),
    );
  }
}