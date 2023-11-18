import 'package:flutter/material.dart';
import 'package:Itine/components/default_button.dart';
import 'package:Itine/size_config.dart';
import 'top_rounded_container.dart';
import '../../delivery.dart';
import 'package:provider/provider.dart';
import '../../../../UseridProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Livreur/dashboard.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';

class DeliveryBody extends StatefulWidget {
  final Map<String, dynamic> delivery;

  DeliveryBody({
    Key? key,
    required this.delivery,
  }) : super(key: key);

  @override
  _DeliveryBodyState createState() => _DeliveryBodyState();
}

class _DeliveryBodyState extends State<DeliveryBody> {
  int milestonesCompletedCount = 0;
  final CategorieService categorieService = CategorieService();
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              _buildDeliveryDetails(),
              _buildActionsSection(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryDetails() {
    return Column(
      children: [
        _buildDetail('Destination', widget.delivery['adresse'].toString()),
        _buildDetail('Prix', widget.delivery['prix'].toString()),
        _buildDetail('Date', widget.delivery['date'].toString()),
        _buildDetail('Statut', widget.delivery['status_livraison']),
      ],
    );
  }

  Widget _buildDetail(String title, String value) {
    if (title == 'Price') {
      return ListTile(
        title: Text(title),
        subtitle: Text('€  $value'),
      );
    }

    if (title == 'Statut' && value == 'start') {
      return ListTile(
        title: Text(title),
        subtitle: Text('Appuyer Démarrer pour commencer'),
      );
    }
    if (title == 'Statut' && value == 'en_cours') {
      return ListTile(
        title: Text(title),
        subtitle: Text('Livraison en cours...'),
      );
    }
    if (title == 'Statut' && value == 'over') {
      return ListTile(
        title: Text(title),
        subtitle: Text('Livraison terminée'),
      );
    }
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return TopRoundedContainer(
      color: Color(0xFFF6F7F9),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.05,
              vertical: getProportionateScreenWidth(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.delivery['status_livraison'] == 'start' &&
                        int.parse(widget.delivery['number_milestone']) > 0
                    ? Expanded(
                        child: DefaultButton(
                          text: 'Démarrer',
                          press: () async {
                            await _handleStartDelivery(context);
                          },
                        ),
                      )
                    : SizedBox(),
                widget.delivery['status_livraison'] == 'en_cours' &&
                        int.parse(widget.delivery['number_milestone']) == 0
                    ? Expanded(
                        child: DefaultButton(
                          text: 'Terminer',
                          press: () async {
                            await handleEndLivraison(context);
                          },
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          SizedBox(height: 20),
          widget.delivery['status_livraison'] == 'en_cours' &&
                  int.parse(widget.delivery['number_milestone']) > 0
              ? _buildMilestoneSection(context)
              : SizedBox(),
          widget.delivery['status_livraison'] == 'over'
              ? SizedBox()
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildTerminateSection(BuildContext context) {
    return Expanded(
      child: DefaultButton(
        text: 'Terminer',
        press: () async {
          await handleEndLivraison(context);
        },
      ),
    );
  }

  Widget _buildMilestoneSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Nombre de milestone : ${widget.delivery['number_milestone']}',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.1,
            vertical: getProportionateScreenWidth(10),
          ),
          child: DefaultButton(
            text:
                'Terminer milestone ${widget.delivery['milestone_completed']}',
            press: () async {
              await _handleMilestoneCompletion(context);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _handleStartDelivery(BuildContext context) async {
    if (widget.delivery['status_livraison'] == 'start') {
      dynamic response = await categorieService.StartLivraion(
        int.parse(widget.delivery['order_id']),
      );

      if (response == false) {
        dynamic response = await categorieService.getlivraisonbystatus(
          int.parse(widget.delivery['livreur_id']),
        );

        userProvider.setUserDelivery(
          response['start'],
          response['over'],
          response['en_cours'],
        );

        Navigator.pushNamed(
          context,
          Dashboard.routeName,
        );
      }
    } else if (widget.delivery['status_livraison'] == 'en_cours') {
      Fluttertoast.showToast(
        msg: 'Cette livraison est déjà en cours',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Cette livraison est déjà terminée',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> handleEndLivraison(BuildContext context) async {
    dynamic response;
    print('Is Zeor');

    // Call the endLivraison method when number_milestone is 0
    response = await categorieService
        .endLivraison(int.parse(widget.delivery['order_id']));

    if (response == false) {
      dynamic response = await categorieService
          .getlivraisonbystatus(int.parse(widget.delivery['livreur_id']));

      userProvider.setUserDelivery(
          response['start'], response['over'], response['en_cours']);
      Navigator.pushNamed(
        context,
        Dashboard.routeName,
      );
    }
  }

  Future<void> _handleMilestoneCompletion(BuildContext context) async {
    dynamic response;

    if (int.parse(widget.delivery['number_milestone']) > 0) {
      response = await categorieService.changeLivraisonMilestone(
        int.parse(widget.delivery['order_id']),
      );
    } else if (int.parse(widget.delivery['number_milestone']) == 0) {
      response = await categorieService.endLivraison(
        int.parse(widget.delivery['order_id']),
      );
    }

    if (response == false) {
      dynamic response = await categorieService.getlivraisonbystatus(
        int.parse(widget.delivery['livreur_id']),
      );

      userProvider.setUserDelivery(
        response['start'],
        response['over'],
        response['en_cours'],
      );

      Navigator.pushNamed(
        context,
        Dashboard.routeName,
      );
    }
  }
}
