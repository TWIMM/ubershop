import 'package:flutter/material.dart';
import 'package:uber/screens/changePassword/changepwd.dart';
import 'package:uber/screens/sign_in/sign_in_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:uber/screens/Messagerie/customercare.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Sécurité",
            icon: "assets/icons/User Icon.svg",
            press: () => Navigator.pushNamed(
              context,
              ChangePwd.routeName,
              arguments: '',
            ),
          ),
          ProfileMenu(
            text: "Discuter avec le service client",
            icon: "assets/icons/Question mark.svg",
            press: () => Navigator.pushNamed(
              context,
              ChatDetailPage.routeName,
              arguments: '',
            ),
          ),
          ProfileMenu(
            text: "Se déconnecter",
            icon: "assets/icons/Log out.svg",
            press: () => Navigator.pushNamed(
              context,
              SignInScreen.routeName,
              arguments: '',
            ),
          ),
        ],
      ),
    );
  }
}
