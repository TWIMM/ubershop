import 'package:flutter/material.dart';
import '../delivery.dart';
import 'components/body.dart'; // Importer le corps de la vue des détails de la livraison
import 'components/custom_app_bar.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  static String routeName = "/delivery_details";

  @override
  Widget build(BuildContext context) {
    final DeliveryDetailsArguments args =
        ModalRoute.of(context)!.settings.arguments as DeliveryDetailsArguments;

    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(
            rating:
                4.1), // Vous pouvez personnaliser la barre d'application pour les détails de livraison si nécessaire
      ),
      body: DeliveryBody(
          delivery:
              args.delivery), // Afficher le corps des détails de la livraison
    );
  }
}

class DeliveryDetailsArguments {
  final dynamic delivery;

  DeliveryDetailsArguments({required this.delivery});
}
