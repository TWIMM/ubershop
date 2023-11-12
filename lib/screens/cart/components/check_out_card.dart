import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uber/components/default_button.dart';
import 'package:uber/screens/home/home_screen.dart';
import 'package:uber/ApiCall/ReqHandler.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatefulWidget {
  final int user_id;
  // final int product_id;

  CheckoutCard({
    Key? key,
    required this.user_id,
    // required this.product_id,
  }) : super(key: key);

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  List cart = [];
  List _productInfo = [];
  String totalCartPrice = '';
  final CategorieService categorieService = CategorieService();

  @override
  void initState() {
    super.initState();
    loadCarts();
    getCartTotal();
  }

  Future<void> loadCarts() async {
    List response = await categorieService.getCart(widget.user_id);
    setState(() {
      cart = response;
    });

    //print(cart);
  }

  Future<void> getCartTotal() async {
    var response = await categorieService.getCartTotal(widget.user_id);
    setState(() {
      totalCartPrice = response;
    });

    print(totalCartPrice);
  }

  Future<void> createorder(totalamount) async {
    var response =
        await categorieService.createorder(widget.user_id, totalamount, cart);

    Navigator.pushNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\€ $totalCartPrice",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Valider mon panier",
                    press: () {
                      createorder(totalCartPrice);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
