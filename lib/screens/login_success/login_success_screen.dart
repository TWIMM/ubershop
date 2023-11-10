import 'package:flutter/material.dart';
import 'package:uber/size_config.dart';
import 'components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    final int user_id = ModalRoute.of(context)?.settings.arguments as int;
    print(user_id);
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(''),
      ),
      body: Body(user_id: user_id),
    );
  }
}
