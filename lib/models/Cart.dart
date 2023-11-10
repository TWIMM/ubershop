import 'Product.dart';

class Cart {
  final Product product;
  int numOfItem;

  Cart({required this.product, required this.numOfItem});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      product: Product.fromJson(json['product']),
      numOfItem: json['numOfItem'],
    );
  }
}

// Demo data for our cart

List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2),
  Cart(product: demoProducts[1], numOfItem: 1),
  Cart(product: demoProducts[3], numOfItem: 1),
];
