import 'package:flutter/material.dart';
import 'trackingmodel.dart';
import 'package:uber/components/coustom_bottom_nav_bar.dart';
import 'package:uber/enums.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key}) : super(key: key);

  @override
  State<MyHomePage2> createState() => _MyHomePageState();
  static String routeName = "/tracking";
}

class _MyHomePageState extends State<MyHomePage2> {
  ///this TextDto present in a package add data in this dto and set in a list.

  List<TextDto> orderList = [
    TextDto("Votre livraison est en cours de traitement", "03-01-2023 , 14:00"),
    TextDto("", "Sun, 27th Mar '22 - 10:19am"),
  ];

  List<TextDto> shippedList = [
    TextDto("Votre commande est à 15 min de vous", "03-01-2023 , 13:20"),
  ];

  List<TextDto> outOfDeliveryList = [
    TextDto("Vous pouvez récuperer votre article", "03-01-2023 , 13:30"),
  ];

  List<TextDto> deliveredList = [
    TextDto("Votre article a été livré", "03-01-2023 , 14:00"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: OrderTracker(
          status: Status.delivered,
          activeColor: Color(0xFFFF1844),
          inActiveColor: Colors.grey[300],
          orderTitleAndDateList: orderList,
          shippedTitleAndDateList: shippedList,
          outOfDeliveryTitleAndDateList: outOfDeliveryList,
          deliveredTitleAndDateList: deliveredList,
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.location),
    );
  }
}
