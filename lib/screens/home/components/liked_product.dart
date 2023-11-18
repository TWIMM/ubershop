import 'package:flutter/material.dart';
import 'Carousel_card.dart';
import 'package:Itine/models/Product.dart';
import 'package:Itine/enums.dart';
import 'package:Itine/components/coustom_bottom_nav_bar.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import '../../cart/components/cart_card.dart';

import '../../../UseridProvider.dart';
import 'package:Itine/screens/home/home_screen.dart';
import 'package:Itine/screens/details/details_screen.dart';
import 'categories.dart';

class LikedProducts extends StatefulWidget {
  static String routeName = "/liked_produit";

  const LikedProducts({Key? key}) : super(key: key);

  @override
  _LikedProductsState createState() => _LikedProductsState();
}

class _LikedProductsState extends State<LikedProducts> {
  final CategorieService categorieService = CategorieService();
  List<Product> allProducts = [];
  int? user_id;
  var userProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProvider = Provider.of<UserProvider>(context);
    user_id = userProvider.user_id;
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    var response = await categorieService.getbestproducts(user_id);
    setState(() {
      allProducts = List<Product>.from(response.map((productMap) {
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
          isFavourite: true,
          isPopular: true,
        );
      }));
    });
  }

  Widget _buildContent(String title, double height) {
    return Container(
      height: height * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title),
              SizedBox(width: 20),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.green,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ],
          ),
          // Other content you want to display
        ],
      ),
    );
  }

  Future<void> deleteCartItem(cartItem_id) async {
    bool response = await categorieService.deleteCartItem(cartItem_id);
    //print(response);

    if (response == false) {
      Navigator.pushNamed(
        context,
        HomeScreen.routeName,
        arguments: '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vos produits préférés"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              top: 10.0,
              left: 10.0,
              bottom: 10.0,
            ),
            child: Container(
              width: 27,
              height: 27,
              child: Image.asset('assets/images/homme.png', width: 7),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              top: 10.0,
              left: 10.0,
              bottom: 10.0,
            ),
            child: Container(
              width: 27,
              height: 27,
              child: Image.asset('assets/images/femme.png', width: 7),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              top: 10.0,
              left: 10.0,
              bottom: 10.0,
            ),
            child: Container(
              width: 27,
              height: 27,
              child: Image.asset('assets/images/enfants.png', width: 7),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
                itemCount: allProducts
                    .length, // Use the length of the fetched cart list
                itemBuilder: (context, index) {
                  dynamic cartItem = allProducts[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(cartItem['id'].toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          allProducts.removeAt(index);
                        });

                        deleteCartItem(cartItem['id']);
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
          ),
        ),
      ),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}
