import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Itine/models/Product.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'customAlert.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(64),
            decoration: BoxDecoration(
              color:
                  product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/Heart Icon_2.svg",
              color:
                  product.isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
              height: getProportionateScreenWidth(16),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            product.description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {
              CustomAlert.showalert(context, product.description);
            },
            child: Row(
              children: [
                Text(
                  "Voir Plus De Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CustomIcons {
  static const IconData add_circle_sharp =
      IconData(0xe74e, fontFamily: 'MaterialIcons');
  static const IconData done_all_outlined =
      IconData(0xefe5, fontFamily: 'MaterialIcons');
  static const IconData push_pin_sharp =
      IconData(0xebea, fontFamily: 'MaterialIcons');
  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');

  static const IconData warning_amber_rounded =
      IconData(0xf02a0, fontFamily: 'MaterialIcons');

  static const IconData account_circle_outlined =
      IconData(0xee35, fontFamily: 'MaterialIcons');
  static const IconData phone_rounded =
      IconData(0xf0083, fontFamily: 'MaterialIcons');
  static const IconData pin_drop =
      IconData(0xe4c7, fontFamily: 'MaterialIcons');
  static const IconData markunread_outlined =
      IconData(0xf1b8, fontFamily: 'MaterialIcons');
  static const IconData map_outlined =
      IconData(0xf1ae, fontFamily: 'MaterialIcons');
  static const IconData maps_home_work =
      IconData(0xe3c9, fontFamily: 'MaterialIcons');
  static const IconData home_outlined =
      IconData(0xf107, fontFamily: 'MaterialIcons');

  static const IconData arrow_circle_left_outlined =
      IconData(0xf05bc, fontFamily: 'MaterialIcons');
  static const IconData arrow_circle_right_outlined =
      IconData(0xf05bd, fontFamily: 'MaterialIcons');

  static const IconData folder_open_outlined =
      IconData(0xf090, fontFamily: 'MaterialIcons');
  static const IconData search = IconData(0xe567, fontFamily: 'MaterialIcons');

  static const IconData shield_outlined =
      IconData(0xf379, fontFamily: 'MaterialIcons');
  static const IconData diversity_2_sharp =
      IconData(0xf0839, fontFamily: 'MaterialIcons');
  static const IconData radio_button_on_outlined =
      IconData(0xf2e5, fontFamily: 'MaterialIcons');
  static const IconData send_outlined =
      IconData(0xf355, fontFamily: 'MaterialIcons', matchTextDirection: true);
  static const IconData sms_outlined =
      IconData(0xf3ad, fontFamily: 'MaterialIcons');
  static const IconData home = IconData(0xe318, fontFamily: 'MaterialIcons');
  static const IconData add = IconData(0xe047, fontFamily: 'MaterialIcons');
  static const IconData bookmarks_outlined =
      IconData(0xeee5, fontFamily: 'MaterialIcons');
}
