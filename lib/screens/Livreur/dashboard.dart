import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:Itine/screens/home/components/home_header.dart';
import 'livreurcard.dart';
import 'package:Itine/models/dashelement.dart';
import './profile/profile_screen.dart';

class Dashboard extends StatefulWidget {
  static String routeName = "/livreurdash";

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DiscountBanner(),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 40,
                children: [
                  // Widget to display deliveries

                  DeliveryCard(
                    title: "Livraison en cours",
                    total: 5,
                  ),

                  // Widget for other menu items
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ProfileScreenLivreur.routeName,
                          arguments: '');
                    },
                    child: OtherMenuItem(
                      title: "Paramètres",
                      icon: Icons.settings,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({
    Key? key,
    required this.title,
    required this.total,
  }) : super(key: key);

  final String title;
  final int total;

  @override
  Widget build(BuildContext context) {
    return LivreurCard(title: title, total: total);
  }
}

class OtherMenuItem extends StatelessWidget {
  const OtherMenuItem({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ParamCard(
      title: title,
      icon: icon,
    );
  }
}

class ParamCard extends StatelessWidget {
  const ParamCard({
    Key? key,
    required this.title,
    this.total,
    this.icon, // Ajout d'une icône optionnelle
  }) : super(key: key);

  final String title;
  final int? total;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor() {
    // Ajoutez ici la logique pour obtenir une couleur selon le titre ou utilisez différentes couleurs par défaut
    // Exemple :
    if (title == 'Delivery Title') {
      return Color(0xFFFF4848);
    } else if (title == 'Other Menu Item') {
      return Color(0xFFFF4848);
    }
    return Color(0xFFFF4848); // Couleur par défaut si aucun titre ne correspond
  }
}

class DiscountBanner extends StatelessWidget {
  final double? solde;
  const DiscountBanner({
    this.solde = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "Votre solde\n"),
            TextSpan(
              text: '€ $solde',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
