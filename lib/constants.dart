import 'package:flutter/material.dart';
import 'package:uber/size_config.dart';

const kPrimaryColor = Color(0xFFFF1844);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFF4B6D), Color(0xFFFF1844)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Veuillez entrer votre Email";
const String kInvalidEmailError = "Veuillez entrer un email Valide";
const String kPassNullError = "Veuillez entrer votre mot de passe";
const String kShortPassError = "Mot de passe trop court";
const String kMatchPassError = "Les mots de passes ne correspondent pas";
const String kNamelNullError = "Veuillez entrer votre nom";
const String kPhoneNumberNullError = "Veuillez entrer votre  numero";
const String kAddressNullError = "Veuillez entrer votre adresse";
const String incorrectAccess = "Identifiants incorrects";
const String incorrectData = "Vos données sont invalide";
const String idnull = "Vos données sont invalide";
const String knullname = "Veuillez entrer votre nom";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

class ApiEndpoints {
  static const register = '/auth/register';
  static const login = '/auth/login';
  static const getuser = '/auth/getuser';

  static const addtocart = '/cart/add';
  static const getcart = '/cart/get';
  static const deletecart = '/cart/delete';

  static const getcategorie = '/categories/getallcategories';
  static const getcategoriebyid = '/categories/getbyid';
  static const getcount = '/categories/getcount';

  static const getproduct = '/produits/getallproduits';
  static const getproductbycategory = '/produits/getproductbycategory';
  static const getspecificproduct = '/produits/getbyid';

  static const changepwd = '/auth/changepwd';
  static const logout = '/auth/logout';

  static const baseUrl = 'https://ottawa-canada.net/public/api';
}

const String baseImageUrl = "https://ottawa-canada.net/public/assets/images";
