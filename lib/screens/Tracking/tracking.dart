import 'package:flutter/material.dart';
import 'trackingmodel.dart';
import 'package:Itine/components/coustom_bottom_nav_bar.dart';
import 'package:Itine/enums.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key}) : super(key: key);

  @override
  State<MyHomePage2> createState() => _MyHomePageState();
  static String routeName = "/tracking";
}

class _MyHomePageState extends State<MyHomePage2> {
  ///this TextDto present in a package add data in this dto and set in a list.

  List step1 = [
    {'date': '23/01/2023'},
  ];

  List step2 = [
    {'date': '24/01/2023'},
  ];

  List step3 = [
    {'date': '25/01/2023'},
  ];

  List step4 = [
    {'date': '26/01/2023'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suivie de colis"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: OrderTracker(
          status: Status.order,
          activeColor: Color(0xFFFF1844),
          inActiveColor: Colors.grey[300],
          orderTitleAndDateList: step1,
          shippedTitleAndDateList: step2,
          outOfDeliveryTitleAndDateList: step3,
          deliveredTitleAndDateList: step4,
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.location),
    );
  }
}
