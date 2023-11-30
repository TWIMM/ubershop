import 'package:flutter/material.dart';
import 'package:Itine/ApiCall/ReqHandler.dart'; // Import your API handler
import '../../../size_config.dart';
import 'pro_by_category.dart';
import 'package:provider/provider.dart';
import '../../../UseridProvider.dart';
import 'section_title.dart';
import '../../../constants.dart';
import 'package:Itine/screens/home/home_screen.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({Key? key}) : super(key: key);

  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  final CategorieService categorieService = CategorieService();
  List<Map<String, dynamic>> categories = [];
  bool isLoading = false;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.loadCategories();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        // Check if categories are available
        if (provider.categories.isEmpty) {
          return CircularProgressIndicator(); // Show loader while loading categories
        } else {
          return buildCategoriesWidget(provider.categories);
        }
      },
    );
  }

  Widget buildCategoriesWidget(List<Map<String, dynamic>> categories) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SectionTitle(
            title: "Categories",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: categories.map((category) {
              return FutureBuilder<int>(
                future: userProvider.loadCount(category['id']),
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (userProvider.isLoading) {
                    return SizedBox(
                      width: getProportionateScreenWidth(50),
                      height: getProportionateScreenWidth(50),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return SizedBox(
                      width: getProportionateScreenWidth(50),
                      height: getProportionateScreenWidth(50),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    if (snapshot.hasData) {
                      return SpecialOfferCard(
                        image: baseImageUrl +
                            '/categories/' +
                            category['background_image'],
                        category: category['label'],
                        numOfBrands: snapshot.data!,
                        press: () => Navigator.pushNamed(
                          context,
                          ProByCategory.routeName,
                          arguments: {'category': category},
                        ),
                      );
                    } else {
                      // If there's no error but the data is null
                      return SizedBox(
                        width: getProportionateScreenWidth(50),
                        height: getProportionateScreenWidth(50),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  }
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
          bottom: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
          top: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(350),
          height: getProportionateScreenWidth(150),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
