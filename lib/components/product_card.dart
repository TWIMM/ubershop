import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Itine/models/Product.dart';
import 'package:Itine/screens/details/details_screen.dart';
import '../constants.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';

import 'package:provider/provider.dart';
import '../../../UseridProvider.dart';
import 'package:Itine/screens/home/home_screen.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    this.height = 200,
    this.width = 140,
    this.aspectRetio = 1.02,
    this.left = 20,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final double height;
  final Product product;
  final double left;
  final CategorieService categorieService = CategorieService();

  Future<void> addbestproducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    var response = await categorieService.addbestproducts(
        userProvider.user_id, product.id);

    if (response == false) {
      userProvider.fetchBestProducts();
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        height: getProportionateScreenWidth(height),
        child: Consumer<UserProvider>(
          // Wrap with Consumer
          builder: (context, userProvider, child) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                DetailsScreen.routeName,
                arguments: ProductDetailsArguments(product: product),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.02,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Hero(
                        tag: product.id.toString(),
                        child: Image.network(
                          baseImageUrl + '/produits/' + product.images[0],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.title,
                    style: TextStyle(color: Colors.black),
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\ €${product.price}",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          addbestproducts(context);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(8)),
                          height: getProportionateScreenWidth(28),
                          width: getProportionateScreenWidth(28),
                          decoration: BoxDecoration(
                            color: userProvider.favoriteProductIds
                                    .contains(product.id)
                                ? kPrimaryColor.withOpacity(0.15)
                                : kSecondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/Heart Icon_2.svg",
                            color: userProvider.favoriteProductIds
                                    .contains(product.id)
                                ? Color(0xFFFF4848)
                                : Color(0xFFDBDEE4),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
