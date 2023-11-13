import 'package:flutter/widgets.dart';
import 'package:Itine/screens/cart/cart_screen.dart';
import 'package:Itine/screens/complete_profile/complete_profile_screen.dart';
import 'package:Itine/screens/details/details_screen.dart';
import 'package:Itine/screens/forgot_password/forgot_password_screen.dart';
import 'package:Itine/screens/home/home_screen.dart';
import 'package:Itine/screens/login_success/login_success_screen.dart';
import 'package:Itine/screens/otp/otp_screen.dart';
import 'package:Itine/screens/profile/profile_screen.dart';
import 'package:Itine/screens/Livreur/profile/profile_screen.dart';
import 'package:Itine/screens/sign_in/sign_in_screen.dart';
import 'package:Itine/screens/splash/splash_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/home/components/allproductbody.dart';
import 'screens/home/components/pro_by_category.dart';
import 'screens/home/components/liked_product.dart';
import 'screens/changePassword/changepwd.dart';
import 'screens/Messagerie/customercare.dart';
import 'screens/Tracking/trackingnumber.dart';
import 'screens/Tracking/tracking.dart';
import 'screens/Livreur/dashboard.dart';
import 'screens/Livreur/retrait.dart';

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
  ProfileScreenLivreur.routeName: (context) => ProfileScreenLivreur(),
  AllProducts.routeName: (context) => AllProducts(),
  ProByCategory.routeName: (context) => ProByCategory(),
  LikedProducts.routeName: (context) => LikedProducts(),
  ChangePwd.routeName: (context) => ChangePwd(),
  ChatDetailPageWrapper.routeName: (context) => ChatDetailPageWrapper(),
  Trackingnumber.routeName: (context) => Trackingnumber(),
  Dashboard.routeName: (context) => Dashboard(),
  MyHomePage2.routeName: (context) => MyHomePage2(),
  Retrait.routeName: (context) => Retrait(),
};
