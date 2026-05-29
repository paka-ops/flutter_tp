import 'package:ecommerce_app/model/produit.dart';
import 'package:ecommerce_app/screens/history_screen.dart';
import 'package:ecommerce_app/screens/panier_screen.dart';
import 'package:ecommerce_app/screens/product_details_screen.dart';
import 'package:ecommerce_app/screens/profile_screen.dart';
import 'package:ecommerce_app/service/products_service.dart';
import 'package:flutter/material.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({Key? key}) : super(key: key);

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  List<Produit> products = [];
  List<Produit> filteredProducts = [];
  List<String> categories = ["Toutes"];
  String selectedCategory = "Toutes";
  String? errorMessage;
  bool isLoading = true;

  Future<void> getAllProduct() async {
    try {
      List data = await ProductService().getProducts();
      List<Produit> loadedProducts = [];
      Set<String> loadedCategories = {};

      for (var element in data) {
        loadedProducts.add(Produit.fromJson(element));
        loadedCategories.add(element['category']);
      }

      setState(() {
        products = loadedProducts;
        filteredProducts = loadedProducts;
        categories = ["Toutes", ...loadedCategories.toList()];
        isLoading = false;
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Erreur: impossible de charger les produits. Vérifiez votre connexion.";
        isLoading = false;
      });
    }
  }

  // fonction pour filtrer les produits par categorie
  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == "Toutes") {
        filteredProducts = products;
      } else {
        filteredProducts = products
            .where((product) => product.category == category)
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Icône pour le Panier
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen())),
            tooltip: "Panier",
          ),
          // Icône pour l'Historique
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen())),
            tooltip: "Historique",
          ),
          // Icône pour le Profil
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
            tooltip: "Profil",
          ),
          const SizedBox(width: 8), // Petit espace à droite
        ],
        title: const Text("Catalogue"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [

          if (categories.length > 1)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: [
                  for (var category in categories)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        selectedColor: Colors.deepPurple.shade100,
                        onSelected: (selected) {
                          if (selected) {
                            filterByCategory(category);
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),


          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage != null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                        errorMessage = null;
                      });
                      getAllProduct();
                    },
                    child: const Text("Réessayer"),
                  ),
                ],
              ),
            )
                : filteredProducts.isEmpty
                ? const Center(
              child: Text("Aucun produit trouvé"),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  elevation: 3,
                  child: InkWell(
                    onTap: () => Navigator.push((context), MaterialPageRoute(builder: (context) => DetailProduitScreen(produit: product))),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.contain,
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                              loadingBuilder: (context, child,
                                  loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const Center(
                                  child:
                                  CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${product.price} €",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                product.category,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}