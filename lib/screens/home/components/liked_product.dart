import 'package:flutter/material.dart';
import 'Liked_card.dart';
import 'package:Itine/models/Product.dart';
import 'package:Itine/enums.dart';
import 'package:Itine/components/coustom_bottom_nav_bar.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import 'package:provider/provider.dart';
import '../../../UseridProvider.dart';
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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 40,
              ),
              itemCount: allProducts.length,
              itemBuilder: (_, int index) {
                final item = allProducts[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  height: 300,
                  child: Column(
                    children: [
                      LikedCard(
                        item: item,
                        user_id: user_id,
                        cardWidth: 270,
                        height: 600,
                        imagePath: item.images[0],
                        title: item.title,
                        isActivated: true,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      Expanded(
                        child: _buildContent(item.title, 600),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}
