import 'package:flutter/material.dart';
import 'package:uber/components/product_card.dart';
import 'package:uber/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';
import 'allproductbody.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Les plus vendus",
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
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  if (demoProducts[index].isPopular == true)
                    return ProductCard(product: demoProducts[index]);

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
