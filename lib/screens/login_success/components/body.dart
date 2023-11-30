import 'package:flutter/material.dart';
import 'package:Itine/components/default_button.dart';
import 'package:Itine/screens/home/home_screen.dart';
import 'package:Itine/size_config.dart';

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
            text: "Valider votre adresse",
            press: () {
              /*  Navigator.pushNamed(
                context,
                HomeScreen.routeName,
              ); */

              showModalBottomSheet(
                context: context,
                backgroundColor:
                    Colors.transparent, // Set background color to transparent
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Set the desired background color
                      ),
                      height: 400,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[],
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            onChanged: (value) {},
                            validator: (value) {},
                            decoration: InputDecoration(
                              labelText: "Adresse",
                              hintText: "Entrez votre adresse",
                              // If  you are using latest version of flutter then lable text and hint text shown like this
                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                          SizedBox(height: 20),
                          DefaultButton(
                            text: "Continuer",
                            press: () async {
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
