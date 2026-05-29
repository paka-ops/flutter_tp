import 'package:ecommerce_app/providers/cart_providers.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/produit.dart';
import 'package:provider/provider.dart';
import '../model/cart_item.dart';

class DetailProduitScreen extends StatefulWidget {
  final Produit produit;

  const DetailProduitScreen({Key? key, required this.produit}) : super(key: key);

  @override
  State<DetailProduitScreen> createState() => _DetailProduitScreenState();
}

class _DetailProduitScreenState extends State<DetailProduitScreen> {
  int quantite = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.produit.title),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. Zone de contenu scrollable (Image + Infos)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 250,
                      child: Image.network(
                        widget.produit.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.produit.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${widget.produit.price} €",
                    style: const TextStyle(fontSize: 24, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Utilisation stricte de ta variable "category"
                  Chip(
                    label: Text(widget.produit.category),
                    backgroundColor: Colors.deepPurple.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.produit.description,
                    style: TextStyle(height: 1.4, fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),

          // 2. Zone d'action fixe en bas (Quantité + Bouton)
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                // Sélecteur de quantité compact
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantite > 1) setState(() => quantite--);
                        },
                        icon: const Icon(Icons.remove, size: 20),
                      ),
                      Text(
                        "$quantite",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => setState(() => quantite++),
                        icon: const Icon(Icons.add, size: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Bouton d'ajout qui prend le reste de la largeur
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () async {
                        final cartProvider = Provider.of<CartProvider>(context, listen: false);

                        final itemToAdd = CartItem(
                          id: widget.produit.id,
                          title: widget.produit.title,
                          price: widget.produit.price.toDouble(),
                          image: widget.produit.image,
                          quantity: quantite,
                        );

                        await cartProvider.addItem(itemToAdd);

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${widget.produit.title} ajouté au panier !"),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 2),
                              action: SnackBarAction(
                                label: "VOIR",
                                textColor: Colors.white,
                                onPressed: () => Navigator.pushNamed(context, '/cart'),
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Ajouter au panier",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}