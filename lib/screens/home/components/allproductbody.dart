import 'package:flutter/material.dart';
import 'package:uber/components/product_card.dart';
import 'package:uber/models/Product.dart';
import 'Carousel_card.dart';
import 'package:uber/screens/details/details_screen.dart';

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
         actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              top: 10.0,
              left: 10.0,
              bottom: 10.0,
            ),
            child: Container(
              width: 37,
              height: 37,
              child: Image.asset('assets/images/homme.png', width: 7),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              top: 10.0,
              left: 10.0,
              bottom: 10.0,
            ),
            child: Container(
              width: 37,
              height: 37,
              child: Image.asset('assets/images/femme.png', width: 7),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              top: 10.0,
              left: 10.0,
              bottom: 10.0,
            ),
            child: Container(
              width: 37,
              height: 37,
              child: Image.asset('assets/images/enfants.png', width: 7),
            ),
          )
        ],
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
                  item: item,
                  cardWidth: 270,
                  height: 400,
                  imagePath: item.images[0],
                  title: item.title,
                  isActivated: true,
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
