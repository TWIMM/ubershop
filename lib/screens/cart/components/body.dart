import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uber/models/Cart.dart';
import 'package:uber/ApiCall/ReqHandler.dart';
import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  final user_id;
  const Body({
    Key? key,
    required this.user_id,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final CategorieService categorieService = CategorieService();
  List cart = []; // Update the type to List<Cart>

  @override
  void initState() {
    super.initState();
    loadCarts();
  }

  Future<void> loadCarts() async {
    List response = await categorieService.getCart(widget.user_id);
    print(response);

    setState(() {
      cart = response;
    });
  }

  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
          itemCount: cart.length, // Use the length of the fetched cart list
          itemBuilder: (context, index) {
            dynamic cartItem = cart[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(cartItem['id'].toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    cart.removeAt(index);
                  });
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: CartCard(cart: cartItem),
              ),
            );
          }),
    );
  }
}
