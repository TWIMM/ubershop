import 'package:flutter/material.dart';
import 'package:Itine/components/AlreadyHaveAccountText.dart';
import '../../constants.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import '../../size_config.dart';
import 'components/sign_up_form.dart';
import 'package:provider/provider.dart';
import 'package:Itine/screens/cart/components/cart_card.dart';
import '../../../UseridProvider.dart';
import 'package:Itine/screens/Tracking/tracking.dart';

class Trackingnumber extends StatefulWidget {
  static String routeName = "/trackingnumber";

  @override
  _TrackingnumberState createState() => _TrackingnumberState();
}

class _TrackingnumberState extends State<Trackingnumber> {
  final CategorieService categorieService = CategorieService();
  List cart = []; // Update the type to List<Cart>
  bool responseBool = true;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    loadCarts();
  }

  Future<void> loadCarts() async {
    List response = await categorieService.getCart(userProvider.user_id);
    print(response);

    setState(() {
      cart = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracking"),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: ListView.builder(
          itemCount: cart.length, // Use the length of the fetched cart list
          itemBuilder: (context, index) {
            dynamic cartItem = cart[index];
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MyHomePage2.routeName,
                    );
                  },
                  child: CartCard(cart: cartItem),
                ));
          },
        ),
      ),
    );
  }
}
