import 'package:flutter/material.dart';
import 'package:uber/components/product_card.dart';
import 'package:uber/models/Product.dart';
import 'Carousel_card.dart';

class ProByCategory extends StatelessWidget {
  static String routeName = "/pro_by_category";

  const ProByCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Produits Par Categorie"),
      ),
      body: Container(
        alignment: Alignment.center,
        height: screenHeight,
        width: screenWidth,
        child: SizedBox(
          height: screenHeight * 0.8,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: demoProducts.length,
            itemBuilder: (context, int index) {
              final item = demoProducts[index];
              return Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: CarouselCard(
                  cardWidth: 270,
                  height: 400,
                  imagePath: item.images[0],
                  title: item.title,
                  isActivated: item.isFavourite,
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
