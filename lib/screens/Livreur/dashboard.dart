import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:uber/screens/home/components/home_header.dart';
import 'livreurcard.dart';
import 'package:uber/models/dashelement.dart';

class Dashboard extends StatefulWidget {
  static String routeName = "/livreurdash";
  const Dashboard({
    Key? key,
  }) : super(key: key);

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
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(user_id:5),
            SizedBox(height: getProportionateScreenWidth(10)),
            Expanded(
              child: LivreurCardGridView(),
            ),
          ],
        ),
      ),
    );
  }
}

class LivreurCardGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        mainAxisExtent: 200,
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 40,
      ),
      itemCount: demoProducts.length,
      itemBuilder: (context, index) {
        final item = demoProducts[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          height: 300,
          child: Column(
            children: [
              LivreurCard(
                title: item.title,
                total: item.total,
                press: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
