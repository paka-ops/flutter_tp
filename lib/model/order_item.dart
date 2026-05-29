class OrderItem {
  final int? id;
  final String date;
  final int itemCount;
  final double total;
  final String productsJson; // Contient la liste des produits en format texte

  OrderItem({
    this.id,
    required this.date,
    required this.itemCount,
    required this.total,
    required this.productsJson,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'itemCount': itemCount,
      'total': total,
      'productsJson': productsJson,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'],
      date: map['date'],
      itemCount: map['itemCount'],
      total: map['total'],
      productsJson: map['productsJson'],
    );
  }
}