import 'package:flutter/widgets.dart';
import 'package:uber/screens/cart/cart_screen.dart';
import 'package:uber/screens/complete_profile/complete_profile_screen.dart';
import 'package:uber/screens/details/details_screen.dart';
import 'package:uber/screens/forgot_password/forgot_password_screen.dart';
import 'package:uber/screens/home/home_screen.dart';
import 'package:uber/screens/login_success/login_success_screen.dart';
import 'package:uber/screens/otp/otp_screen.dart';
import 'package:uber/screens/profile/profile_screen.dart';
import 'package:uber/screens/sign_in/sign_in_screen.dart';
import 'package:uber/screens/splash/splash_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/home/components/allproductbody.dart';
import 'screens/home/components/pro_by_category.dart';
import 'screens/home/components/liked_product.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  AllProducts.routeName: (context) => AllProducts(),
  ProByCategory.routeName: (context) => ProByCategory(),
  LikedProducts.routeName: (context) => LikedProducts(),
};
