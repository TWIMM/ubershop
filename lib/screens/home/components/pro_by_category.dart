import 'package:flutter/material.dart';
import 'package:Itine/components/product_card.dart';
import 'package:Itine/models/Product.dart';
import 'Carousel_card.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import 'package:Itine/screens/details/details_screen.dart';
import 'package:provider/provider.dart'; // Import the provider package
import '../../../UseridProvider.dart'; // Import your UserProvider

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

  List<Map<String, dynamic>> produits = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    category = args['category'];
    loadCategories();
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

    // Wrap the relevant part with Consumer<UserProvider>
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Produits Par Categorie"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                padding: const EdgeInsets.all(10.0),
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
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 27,
                  height: 27,
                  child: Image.asset('assets/images/enfants.png', width: 7),
                ),
              )
            ],
          ),
          body: Container(
            alignment: Alignment.center,
            height: screenHeight,
            width: screenWidth,
            child: SizedBox(
              height: screenHeight * 0.8,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisExtent: 200,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 40,
                ),
                itemCount: produits.length,
                itemBuilder: (_, int index) {
                  List<Product> convertedProducts = produits.map((productMap) {
                    return Product(
                      id: productMap["id"] as int,
                      images: List<String>.from(productMap["images_names"]),
                      colors: productMap["availaible_colors"].map((hexString) {
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
                          cardWidth: 270,
                          height: 600,
                          imagePath: item.images[0],
                          title: item.title,
                          isActivated:
                              userProvider.favoriteProductIds.contains(item.id),
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
        );
      },
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
