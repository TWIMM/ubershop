// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'custom_card.dart';
import 'package:flutter/material.dart';
import 'package:Itine/screens/details/details_screen.dart';
import 'package:Itine/components/default_button.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import 'package:Itine/screens/details/details_screen.dart';
import 'package:Itine/screens/home/home_screen.dart';
import 'package:Itine/models/Product.dart';

class CarouselCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final double height;
  final double cardWidth;
  final BorderRadius borderRadius;
  final Product item;
  final user_id;
  final bool? isActivated;

  CarouselCard({
    Key? key,
    required this.imagePath,
    required this.title,
    this.height = 0,
    required this.item,
    this.user_id,
    this.cardWidth = 0,
    this.isActivated,
    required this.borderRadius,
  }) : super(key: key);

  @override
  _CarouselCardState createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard> {
  bool isActivated = true;
  final CategorieService categorieService = CategorieService();

  Future<void> addbestproducts() async {
    var response =
        await categorieService.addbestproducts(widget.user_id, widget.item!.id);

    if (response == false) {
      setState(() {
        isActivated = !isActivated;
      });
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: widget.cardWidth,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(211, 209, 216, 0.30),
                offset: Offset(5, 10),
                blurRadius: 20)
          ],
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImage(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        height: widget.height * 0.27,
        width: double.infinity,
        imageUrl: widget.imagePath,
        borderRadius: BorderRadius.circular(8),
        isBackground: true,
        childWidget: Stack(
          children: [
            Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments: ProductDetailsArguments(product: widget.item!),
                  ),
                  child: CustomCard(
                    childWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Détails',
                            style: TextStyle(color: Color(0xFFFF1844))),
                      ],
                    ),
                    width: 100,
                    height: 30,
                    borderRadius: BorderRadius.circular(80),
                  ),
                )),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  addbestproducts();
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: isActivated
                        ? const Color.fromARGB(255, 249, 188, 184)
                        : Color.fromARGB(118, 187, 187, 187),
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: isActivated ? Colors.red : Colors.white,
                    size: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
