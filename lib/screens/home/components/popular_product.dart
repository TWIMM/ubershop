import 'package:flutter/material.dart';
import 'package:uber/components/product_card.dart';
import 'package:uber/models/Product.dart';
import 'package:uber/ApiCall/ReqHandler.dart';
import '../../../size_config.dart';
import 'section_title.dart';
import 'allproductbody.dart';

class PopularProducts extends StatefulWidget {
  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  final CategorieService categorieService = CategorieService();
  List<Product> popularProducts = [];
  List<Map<String, dynamic>> produits = [];

  @override
  void initState() {
    super.initState();
    // Fetch popular products or initialize the list
    fetchPopularProducts();
  }

  Future<void> fetchPopularProducts() async {
    var response = await categorieService.getproducts();
    print(response);
    setState(() {
      produits = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Product> convertedProducts = produits.map((productMap) {
      //print(productMap["availaible_colors"]);
      //print(productMap);
      return Product(
        id: productMap["id"] as int,
        images: List<String>.from(productMap["images_names"]),
        colors: productMap["availaible_colors"].map((hexString) {
          int colorInt = int.parse(hexString.substring(2), radix: 16);

          return Color(colorInt);
        }).toList(),
        title: productMap["label"],
        price: productMap["price"],
        description: productMap["description"],
        rating: 4.1,
        isFavourite: false,
        isPopular: false,
      );
    }).toList();

    List<Product> limitedProducts = convertedProducts.take(10).toList();

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Produits",
            press: () => Navigator.pushNamed(
              context,
              AllProducts.routeName,
              arguments: 'none',
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...limitedProducts
                  .map((product) => ProductCard(product: product))
                  .toList(),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}
