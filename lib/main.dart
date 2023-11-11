import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber/routes.dart';
import 'package:uber/screens/splash/splash_screen.dart';
import 'package:uber/theme.dart';
import 'UseridProvider.dart'; // Import your UserProvider file

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          UserProvider(), // Wrap the app with ChangeNotifierProvider
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Itine',
      theme: AppTheme.lightTheme(context),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
