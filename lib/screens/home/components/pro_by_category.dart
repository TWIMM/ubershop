import 'package:flutter/material.dart';
import 'package:uber/components/product_card.dart';
import 'package:uber/models/Product.dart';
import 'Carousel_card.dart';
import 'package:uber/screens/details/details_screen.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              top: 10.0,
              left: 10.0,
              bottom: 10.0,
            ),
            child: Container(
              width: 27,
              height: 27,
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
              width: 27,
              height: 27,
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
              width: 27,
              height: 27,
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
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 40),
            itemCount: demoProducts.length,
            itemBuilder: (_, int index) {
              final item = demoProducts[index];
              return Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  height: 300,
                  child: Column(children: [
                    CarouselCard(
                      item: item,
                      cardWidth: 270,
                      height: 600,
                      imagePath: item.images[0],
                      title: item.title,
                      isActivated: true,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    Expanded(
                      child: _buildContent(item.title, 600),
                    )
                  ]));
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildContent(
  title,
  height,
) {
  return Container(
    height: height * 0.35,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.green,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 10,
              ),
            ),
          ],
        ),
        /*   Row(
          children: [
            Text("Livraison rapide"),
            SizedBox(
              width: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.timer,
                  size: 15,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ), */

        /*   Padding(
            padding: const EdgeInsets.only(
                right: 17.0, top: 17.0, left: 17.0, bottom: 17.0),
            child: DefaultButton(
              text: "Détail",
              press: () {
                Navigator.pushNamed(
                  context,
                  DetailsScreen.routeName,
                  arguments: ProductDetailsArguments(product: widget.item!),
                );
              },
            ),
          ) */
      ],
    ),
  );
}
