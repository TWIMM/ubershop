import 'package:flutter/material.dart';
import 'package:uber/components/product_card.dart';
import 'package:uber/models/Product.dart';
import 'Carousel_card.dart';

class AllProducts extends StatelessWidget {
  static String routeName = "/allproducts";

  const AllProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final favoriteProducts =
        demoProducts.where((product) => product.isPopular == true).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Les plus vendus"),
      ),
      body: Container(
        alignment: Alignment.center,
        height: screenHeight,
        width: screenWidth,
        child: SizedBox(
          height: screenHeight * 0.8,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: favoriteProducts.length,
            itemBuilder: (context, int index) {
              final item = favoriteProducts[index];
              return Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: CarouselCard(
                  cardWidth: 270,
                  height: 400,
                  imagePath: item.images[0],
                  title: item.title,
                  isActivated: item.isPopular,
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
