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
  int? user_id;
  bool isLoading = false;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchBestProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vos produits préférés"),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 40,
                  ),
                  itemCount: userProvider.allProducts.length,
                  itemBuilder: (_, int index) {
                    final item = userProvider.allProducts[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      height: 300,
                      child: Column(
                        children: [
                          LikedCard(
                            item: item,
                            user_id: userProvider.user_id,
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
              );
            },
          ),
        ),
      ),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
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
}
