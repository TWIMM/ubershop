import 'package:flutter/material.dart';
import 'package:uber/components/coustom_bottom_nav_bar.dart';
import 'package:uber/enums.dart';
import '../../size_config.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    final int user_id = ModalRoute.of(context)?.settings.arguments as int;
    SizeConfig().init(context);
    return Scaffold(
      body: Body(user_id: user_id),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
