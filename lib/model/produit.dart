class Produit{
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Map<String, dynamic> rating = {};

  Produit({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required rating,
  });
  factory Produit.fromJson(Map<String, dynamic> json){
    return Produit(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'],
    );
  }
}