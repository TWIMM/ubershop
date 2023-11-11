import 'package:flutter/material.dart';
import 'package:uber/components/default_button.dart';
import 'package:uber/screens/home/home_screen.dart';
import 'package:uber/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/good.jpg",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Connexion réussie",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Aller à la page d'acceuil",
            press: () {
              Navigator.pushNamed(
                context,
                HomeScreen.routeName,
              );
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
