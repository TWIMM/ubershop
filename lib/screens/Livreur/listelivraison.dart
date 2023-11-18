import 'package:flutter/material.dart';
import 'delivery.dart';
import './details/details_screen.dart';

class Liste extends StatefulWidget {
  static String routeName = "/Liste";

  @override
  State<Liste> createState() => _DashboardState();
}

class _DashboardState extends State<Liste> {
  List deliveries = [];

  @override
  Widget build(BuildContext context) {
    deliveries =
        ModalRoute.of(context)?.settings.arguments as List<dynamic> ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Liste"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 17),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 17,
                  mainAxisSpacing: 40,
                ),
                itemCount: deliveries.length,
                itemBuilder: (context, index) {
                  final delivery = deliveries[index];
                  return DeliveryCard(
                    delivery: delivery,
                    orderId: delivery['order_id']?.toString() ?? '',
                    livreurId: delivery['livreur_id']?.toString() ?? '',
                    date: delivery['date'] ?? '',
                    adresse: delivery['adresse'] ?? '',
                    prix: double.parse(delivery['prix']?.toString() ?? '0.0'),
                    numberMilestone: int.parse(
                        delivery['number_milestone']?.toString() ?? '0'),
                    statusLivraison: delivery['status_livraison'] ?? '',
                    milestoneCompleted: int.parse(
                        delivery['milestone_completed']?.toString() ?? '0'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  final String orderId;
  final String livreurId;
  final String date;
  final String adresse;
  final double prix;
  final delivery;
  final int numberMilestone;
  final String statusLivraison;
  final int milestoneCompleted;

  DeliveryCard({
    required this.orderId,
    required this.livreurId,
    required this.date,
    required this.adresse,
    required this.prix,
    required this.delivery,
    required this.numberMilestone,
    required this.statusLivraison,
    required this.milestoneCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DeliveryDetailsScreen.routeName,
          arguments: DeliveryDetailsArguments(delivery: delivery),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: _getColor(),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                adresse,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              SizedBox(height: 10),
              Text(
                'Date: $date',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              Text(
                'Montant: € $prix',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    return Color(0xFFFF4848); // Change color logic here
  }
}
