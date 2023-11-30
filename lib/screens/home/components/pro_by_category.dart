import 'package:flutter/material.dart';
import 'package:Itine/components/product_card.dart';
import 'package:Itine/models/Product.dart';
import 'Carousel_card.dart';
import 'package:provider/provider.dart';
import '../../../UseridProvider.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import 'package:Itine/screens/details/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:Itine/constants.dart';

class ProByCategory extends StatefulWidget {
  static String routeName = "/pro_by_category";

  ProByCategory({
    Key? key,
  }) : super(key: key);

  @override
  _ProByCategoryState createState() => _ProByCategoryState();
}

class _ProByCategoryState extends State<ProByCategory> {
  final CategorieService categorieService = CategorieService();
  dynamic category;
  late UserProvider userProvider;
  int selectedMenu = 0; // 0 for Homme, 1 for Femme, 2 for Enfants

  List<Map<String, dynamic>> produits = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    category = args['category'];
    loadCategories();
    userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.fetchBestProducts();
  }

  Future<void> loadCategories() async {
    dynamic response =
        await categorieService.getProductByCategories(category['id']);
    setState(() {
      produits = List<Map<String, dynamic>>.from(response);
    });
  }

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Produits Par Categorie"),
          ),
          body: Container(
            alignment: Alignment.center,
            height: screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildFilterButton("Homme", 0),
                      SizedBox(width: 16),
                      _buildFilterButton("Femme", 1),
                      SizedBox(width: 16),
                      _buildFilterButton("Enfants", 2),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      mainAxisExtent: 200,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 40,
                    ),
                    itemCount: produits.length,
                    itemBuilder: (_, int index) {
                      List<Product> convertedProducts =
                          produits.map((productMap) {
                        return Product(
                          id: productMap["id"] as int,
                          images: List<String>.from(productMap["images_names"]),
                          colors:
                              productMap["availaible_colors"].map((hexString) {
                            int colorInt =
                                int.parse(hexString.substring(2), radix: 16);
                            return Color(colorInt);
                          }).toList(),
                          title: productMap["label"],
                          price: productMap["price"],
                          description: productMap["description"],
                          rating: 4.1,
                          isFavourite: true,
                          isPopular: true,
                        );
                      }).toList();

                      final item = convertedProducts[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        height: 300,
                        child: Column(
                          children: [
                            CarouselCard(
                              item: item,
                              user_id: userProvider.user_id,
                              cardWidth: 270,
                              height: 600,
                              imagePath: item.images[0],
                              title: item.title,
                              isActivated: userProvider.favoriteProductIds
                                  .contains(item.id),
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterButton(String label, int menuIndex) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedMenu = menuIndex;
        });
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white, // Unchanged button color
        elevation: 0, // Remove box shadow
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selectedMenu == menuIndex ? kPrimaryColor : Colors.black,
        ),
      ),
    );
  }

  Widget _buildContent(
    title,
    height,
  ) {
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
              SizedBox(
                width: 20,
              ),
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
        ],
      ),
    );
  }
}
