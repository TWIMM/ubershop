import 'package:flutter/material.dart';
import 'package:uber/components/product_card.dart';
import 'package:uber/models/Product.dart';

class AllProducts extends StatelessWidget {
  static String routeName = "/allproducts";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0,
            children: List.generate(demoProducts.length, (index) {
              return Center(
                child: ProductCard(product: demoProducts[index]),
              );
            })));
  }
}
