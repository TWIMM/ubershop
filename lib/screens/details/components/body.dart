import 'package:flutter/material.dart';
import 'package:Itine/components/default_button.dart';
import 'package:Itine/models/Product.dart';
import 'package:Itine/size_config.dart';
import 'package:provider/provider.dart';
import '../../../UseridProvider.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import 'package:Itine/screens/home/home_screen.dart';

class Body extends StatelessWidget {
  final Product product;

  Body({Key? key, required this.product}) : super(key: key);

  final CategorieService categorieService = CategorieService();

  Future<void> addToCart(user_id, context) async {
    dynamic response = await categorieService.addToCart(product.id, user_id);
    print(response);
    if (response['cart'] != null) {
      Navigator.pushNamed(
        context,
        HomeScreen.routeName,
      );
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    // Access the userId using userProvider.userId
    int user_id = userProvider.user_id;
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
                            addToCart(user_id, context);
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
