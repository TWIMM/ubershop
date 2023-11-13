import 'package:flutter/material.dart';
import 'package:Itine/components/custom_surfix_icon.dart';
import 'package:Itine/components/default_button.dart';
import 'package:Itine/components/form_error.dart';
import 'package:Itine/screens/complete_profile/complete_profile_screen.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class Retrait extends StatefulWidget {
  static String routeName = "/retrait";

  @override
  _RetraitState createState() => _RetraitState();
}

class _RetraitState extends State<Retrait> {
  final _formKey = GlobalKey<FormState>();
  String? iban;
  String? bic;
  String? beneficiaryName;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrait"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildIbanFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildBicFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildBeneficiaryNameFormField(),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(40)),
              DefaultButton(
                text: "Continuer",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Handle the IBAN, BIC, BeneficiaryName data
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildIbanFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => iban = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Veuillez saisir votre IBAN");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "IBAN",
        hintText: "Entrez votre IBAN",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildBicFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => bic = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Veuillez saisir votre BIC");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "BIC",
        hintText: "Entrez votre BIC",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildBeneficiaryNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => beneficiaryName = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Veuillez saisir le nom du bénéficiaire");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nom du bénéficiaire",
        hintText: "Entrez le nom du bénéficiaire",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User Icon.svg"),
      ),
    );
  }
}
