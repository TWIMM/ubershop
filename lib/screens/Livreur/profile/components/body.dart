import 'package:flutter/material.dart';
import 'package:Itine/screens/changePassword/changepwd.dart';
import 'package:Itine/screens/sign_in/sign_in_screen.dart';
import 'profile_menu.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'profile_pic.dart';
import 'package:provider/provider.dart';
import '../../../../UseridProvider.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import '../../retrait.dart';
import 'package:Itine/screens/Messagerie/customercare.dart';

class Body extends StatelessWidget {
  final CategorieService categorieService = CategorieService();

  Future<void> logout(user_id, context) async {
    bool response = await categorieService.logout(user_id);

    if (response == false) {
      /*  Navigator.pushNamed(
        context,
        SignInScreen.routeName,
      ); */
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
    //print(cart);
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    int user_id = userProvider.user_id;
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
            text: "Effectuer un retrait",
            icon: "assets/icons/Question mark.svg",
            press: () => Navigator.pushNamed(
              context,
              Retrait.routeName,
              arguments: '',
            ),
          ),
          ProfileMenu(
            text: "Se déconnecter",
            icon: "assets/icons/Log out.svg",
            press: () {
              logout(user_id, context);
            },
          ),
        ],
      ),
    );
  }
}
