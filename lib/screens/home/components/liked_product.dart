import 'package:flutter/material.dart';
import 'Carousel_card.dart';
import 'package:uber/models/Product.dart';
import 'package:uber/enums.dart';
import 'package:uber/components/coustom_bottom_nav_bar.dart';
import 'package:uber/screens/details/details_screen.dart';
import 'categories.dart';

class LikedProducts extends StatelessWidget {
  static String routeName = "/liked_produit";

  const LikedProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a list of favorite products by filtering demoProducts.
    final favoriteProducts =
        demoProducts.where((product) => product.isFavourite == true).toList();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Vos produits préférés"),
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
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: screenHeight,
          width: screenWidth,
          child: SizedBox(
            height: screenHeight * 0.75,
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
      ),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}
