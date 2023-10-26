import 'package:flutter/material.dart';
import 'Carousel_card.dart';
import 'package:uber/models/Product.dart';
import 'package:uber/enums.dart';
import 'package:uber/components/coustom_bottom_nav_bar.dart';

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
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: screenHeight * 0.8,
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
                    isActivated: item.isFavourite,
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
