import 'package:flutter/material.dart';

class LivreurCard extends StatelessWidget {
  const LivreurCard({
    Key? key,
    required this.title,
    required this.total,
    required this.press,
  }) : super(key: key);

  final String title;
  final int total;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return _buildImage();
  }

  Widget _buildImage() {
    return SizedBox(
        width: 100,
        child: Container(
          child: Column(
            children: [
              Text(title),
              SizedBox(height: 10),
              Text('Total : $total'),
            ],
          ),
          width: 100,
          height: 100,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(211, 209, 216, 0.30),
                    offset: Offset(5, 10),
                    blurRadius: 20)
              ],
              color: Color(0xFFFF1844)),
        ));
  }
}
