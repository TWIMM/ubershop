import 'package:flutter/material.dart';

class LivreurCard extends StatelessWidget {
  const LivreurCard({
    Key? key,
    required this.title,
    required this.total,
    this.icon, // Ajout d'une icône optionnelle
  }) : super(key: key);

  final String title;
  final int total;
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
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              'Total: $total',
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
