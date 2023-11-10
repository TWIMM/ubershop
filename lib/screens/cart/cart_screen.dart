import 'package:flutter/material.dart';
import 'package:uber/models/Cart.dart';
import '../../size_config.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final user_id = ModalRoute.of(context)?.settings.arguments;
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(user_id: user_id),
      bottomNavigationBar: CheckoutCard(user_id: user_id),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Votre Panier",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
