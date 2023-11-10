import 'package:flutter/material.dart';
import 'package:uber/components/default_button.dart';
import 'package:uber/models/Product.dart';
import 'package:uber/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:uber/ApiCall/ReqHandler.dart';

class Body extends StatelessWidget {
  final Product product;
  final int? user_id;

  Body({Key? key, required this.product, this.user_id}) : super(key: key);

  final CategorieService categorieService = CategorieService();

  Future<void> addToCart() async {
    dynamic response = await categorieService.addToCart(product.id, user_id);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Ajouter au panier",
                          press: () {
                            addToCart();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
