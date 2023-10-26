// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'custom_card.dart';
import 'package:flutter/material.dart';

class CarouselCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final double height;
  final double cardWidth;
  final BorderRadius borderRadius;

  final bool isActivated;

  CarouselCard({
    Key? key,
    required this.imagePath,
    required this.title,
    this.height = 0,
    this.cardWidth = 0,
    this.isActivated = false,
    required this.borderRadius,
  }) : super(key: key);

  @override
  _CarouselCardState createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard> {
  bool isActivated = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: widget.cardWidth,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(211, 209, 216, 0.30),
                offset: Offset(5, 10),
                blurRadius: 20)
          ],
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImage(),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      width: double.infinity,
      height: widget.height * 0.6,
      child: CustomCard(
        height: double.infinity,
        width: double.infinity,
        imageUrl: widget.imagePath,
        borderRadius: BorderRadius.circular(8),
        isBackground: true,
        childWidget: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CustomCard(
                childWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('4.5'),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 15,
                    ),
                    Text('+25')
                  ],
                ),
                width: 100,
                height: 40,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isActivated = !isActivated;
                  });
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: isActivated == true
                        ? const Color.fromARGB(255, 249, 188, 184)
                        : Color.fromARGB(118, 187, 187, 187),
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: isActivated == true ? Colors.red : Colors.white,
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

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      height: widget.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.title),
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
          Row(
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
                  Text("10-15 min"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
