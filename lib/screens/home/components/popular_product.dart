import 'package:flutter/material.dart';
import 'package:Itine/components/product_card.dart';
import 'package:Itine/models/Product.dart';
import '../../../size_config.dart';
import '../../../UseridProvider.dart';

import 'section_title.dart';
import 'allproductbody.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        if (userProvider.popularProducts.isEmpty) {
          // Fetch popular products if the list is empty
          userProvider.fetchPopularProducts();
          return CircularProgressIndicator();
        } else {
          return buildProductsWidget(userProvider.popularProducts, context);
        }
      },
    );
  }

  Widget buildProductsWidget(List<Product> products, BuildContext context) {
    List<Product> limitedProducts = products.take(10).toList();

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
