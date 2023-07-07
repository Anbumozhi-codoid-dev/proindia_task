class Product {
  String productName;
  String productId;
  int availableQuantity;

  Product(this.productName, this.productId, this.availableQuantity);

  factory Product.fromJson(Map<String, dynamic> json) {
    final productName = json['productName'].toString();
    final productId = json['productId'].toString();
    final availableQuantity = json['availableQuantity'];

    return Product(productName, productId, availableQuantity);
  }
}
