import 'package:flutter/material.dart';
import 'package:Itine/components/product_card.dart';
import 'package:Itine/models/Product.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import 'Carousel_card.dart';
import 'package:Itine/screens/details/details_screen.dart';

class AllProducts extends StatefulWidget {
  static String routeName = "/allproducts";

  const AllProducts({Key? key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final CategorieService categorieService = CategorieService();
  List<Product> convertedProducts = [];

  @override
  void initState() {
    super.initState();
    fetchPopularProducts();
  }

  Future<void> fetchPopularProducts() async {
    var response = await categorieService.getproducts();
    setState(() {
      convertedProducts = List<Product>.from(response.map((productMap) {
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
        title: Text("Nos produits"),
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
      body: Container(
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
            itemCount: convertedProducts.length,
            itemBuilder: (_, int index) {
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
    );
  }
}
