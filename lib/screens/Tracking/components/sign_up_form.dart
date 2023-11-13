import 'package:flutter/material.dart';
import 'package:Itine/components/custom_surfix_icon.dart';
import 'package:Itine/components/default_button.dart';
import 'package:Itine/components/form_error.dart';
import 'package:Itine/screens/sign_in/sign_in_screen.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../tracking.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  String? email;
  String? password;
  String? conform_password;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continuer",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                Navigator.pushNamed(context, MyHomePage2.routeName);
                /* // bool response = await authService.register(email!, password!);
                print(response);
                if (response == false) {
                  addError(error: incorrectData);
                } else {
                  // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  removeError(error: incorrectAccess);
                } */
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: idnull);
        } else if (value.length >= 8) {
          removeError(error: idnull);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: idnull);
          return "";
        } else if (value.length < 8) {
          addError(error: idnull);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "ID commande",
        hintText: "ID commande",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
