import 'package:flutter/material.dart';
import 'package:Itine/components/coustom_bottom_nav_bar.dart';
import 'package:Itine/enums.dart';

import 'components/body.dart';

class ProfileScreenLivreur extends StatelessWidget {
  static String routeName = "/profilelivreur";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Body(),
    );
  }
}
