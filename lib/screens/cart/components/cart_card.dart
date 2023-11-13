import 'package:flutter/material.dart';
import 'package:Itine/models/Cart.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final dynamic cart;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  final CategorieService categorieService = CategorieService();
  dynamic _product;

  @override
  void initState() {
    super.initState();
    getProductFromId();
  }

  Future<void> getProductFromId() async {
    var response =
        await categorieService.getProductFromId(widget.cart['product_id']);
    print(response);

    setState(() {
      _product = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _product != null
        ? Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(
                      baseImageUrl + '/produits/' + _product['images_names'],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _product['label'],
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    maxLines: 2,
                  ),
                  SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: "\€ " + _product['price'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: " x" + widget.cart['quantity'],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        : Container(); // Return an empty container or loading widget if product is still being fetched
  }
}
