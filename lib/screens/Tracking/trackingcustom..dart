import 'package:flutter/material.dart';

class OrderTracker extends StatefulWidget {
  final Status status;
  final List<TextDto>? orderTitleAndDateList;
  final List<TextDto>? shippedTitleAndDateList;
  final List<TextDto>? outOfDeliveryTitleAndDateList;
  final List<TextDto>? deliveredTitleAndDateList;
  final Color activeColor;
  final Color inActiveColor;
  final TextStyle headingTitleStyle;
  final TextStyle headingDateTextStyle;
  final TextStyle subTitleTextStyle;
  final TextStyle subDateTextStyle;

  OrderTracker({
    Key? key,
    required this.status,
    this.orderTitleAndDateList,
    this.shippedTitleAndDateList,
    this.outOfDeliveryTitleAndDateList,
    this.deliveredTitleAndDateList,
    this.activeColor = const Color(0xFFFF1844),
    this.inActiveColor = Colors.grey,
    this.headingTitleStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    this.headingDateTextStyle =
        const TextStyle(fontSize: 16, color: Colors.grey),
    this.subTitleTextStyle = const TextStyle(fontSize: 14),
    this.subDateTextStyle = const TextStyle(fontSize: 14, color: Colors.grey),
  }) : super(key: key);

  @override
  State<OrderTracker> createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker>
    with TickerProviderStateMixin {
  AnimationController? controller;
  AnimationController? controller2;
  AnimationController? controller3;
  bool isFirst = false;
  bool isSecond = false;
  bool isThird = false;

  @override
  void initState() {
    if (widget.status == Status.order) {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller!.value > 0.99) {
            controller?.stop();
          }
          setState(() {});
        });
    } else if (widget.status == Status.shipped) {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller!.value > 0.99) {
            controller?.stop();
            controller2?.stop();
            isFirst = true;
            controller2?.forward(from: 0.0);
          }
          setState(() {});
        });

      controller2 = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller2!.value > 0.99) {
            controller2?.stop();
            controller3?.stop();
            isSecond = true;
            controller3?.forward(from: 0.0);
          }
          setState(() {});
        });
    } else if (widget.status == Status.outOfDelivery ||
        widget.status == Status.delivered) {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller!.value > 0.99) {
            controller?.stop();
            controller2?.stop();
            controller3?.stop();
            isFirst = true;
            controller2?.forward(from: 0.0);
          }
          setState(() {});
        });

      controller2 = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller2!.value > 0.99) {
            controller2?.stop();
            controller3?.stop();
            isSecond = true;
            controller3?.forward(from: 0.0);
          }
          setState(() {});
        });

      controller3 = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller3!.value > 0.99) {
            controller3?.stop();
            isThird = true;
          }
          setState(() {});
        });
    }

    controller?.repeat(reverse: false);
    controller2?.repeat(reverse: false);
    controller3?.repeat(reverse: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderStatus(
          status: widget.status,
          title: "Démarrée",
          date: "Fri, 25th Mar '22",
          titleStyle: widget.headingTitleStyle,
          dateStyle: widget.headingDateTextStyle,
          isActive: controller!.value > 0.99,
          progressBar: OrderProgressBar(
            progress: controller?.value ?? 0.0,
            activeColor: widget.activeColor,
            inActiveColor: widget.inActiveColor,
          ),
          orderDetails: OrderDetails(
            details: widget.orderTitleAndDateList,
            subTitleStyle: widget.subTitleTextStyle,
            subDateStyle: widget.subDateTextStyle,
          ),
        ),
        if (widget.status == Status.shipped ||
            widget.status == Status.outOfDelivery ||
            widget.status == Status.delivered)
          OrderStatus(
            status: widget.status,
            title: "Livraison démarrée",
            date: "Fri, 28th Mar '22",
            titleStyle: widget.headingTitleStyle,
            dateStyle: widget.headingDateTextStyle,
            isActive: isFirst,
            progressBar: OrderProgressBar(
              progress: controller2?.value ?? 0.0,
              activeColor: isFirst ? widget.activeColor : widget.inActiveColor,
              inActiveColor: widget.inActiveColor,
            ),
            orderDetails: OrderDetails(
              details: widget.shippedTitleAndDateList,
              subTitleStyle: widget.subTitleTextStyle,
              subDateStyle: widget.subDateTextStyle,
            ),
          ),
        if (widget.status == Status.outOfDelivery ||
            widget.status == Status.delivered)
          OrderStatus(
            status: widget.status,
            title: "Proche de vous",
            date: "Fri, 29th Mar '22",
            titleStyle: widget.headingTitleStyle,
            dateStyle: widget.headingDateTextStyle,
            isActive: isSecond,
            progressBar: OrderProgressBar(
              progress: controller3?.value ?? 0.0,
              activeColor: isSecond ? widget.activeColor : widget.inActiveColor,
              inActiveColor: widget.inActiveColor,
            ),
            orderDetails: OrderDetails(
              details: widget.outOfDeliveryTitleAndDateList,
              subTitleStyle: widget.subTitleTextStyle,
              subDateStyle: widget.subDateTextStyle,
            ),
          ),
        if (widget.status == Status.delivered)
          OrderStatus(
            status: widget.status,
            title: "Article livré",
            date: "Fri, 31th Mar '22",
            titleStyle: widget.headingTitleStyle,
            dateStyle: widget.headingDateTextStyle,
            isActive: isThird,
            progressBar: OrderProgressBar(
              progress: 1.0,
              activeColor: isThird ? widget.activeColor : widget.inActiveColor,
              inActiveColor: widget.inActiveColor,
            ),
            orderDetails: OrderDetails(
              details: widget.deliveredTitleAndDateList,
              subTitleStyle: widget.subTitleTextStyle,
              subDateStyle: widget.subDateTextStyle,
            ),
          ),
      ],
    );
  }
}

class OrderStatus extends StatelessWidget {
  final Status status;
  final String title;
  final String date;
  final TextStyle titleStyle;
  final TextStyle dateStyle;
  final bool isActive;
  final OrderProgressBar progressBar;
  final OrderDetails orderDetails;

  OrderStatus({
    required this.status,
    required this.title,
    required this.date,
    required this.titleStyle,
    required this.dateStyle,
    this.isActive = false,
    required this.progressBar,
    required this.orderDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: isActive
                    ? progressBar.activeColor
                    : progressBar.inActiveColor,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(width: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: titleStyle,
                  ),
                  TextSpan(
                    text: date,
                    style: dateStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: SizedBox(
                width: 2,
                height: orderDetails.details != null &&
                        orderDetails.details!.isNotEmpty
                    ? orderDetails.details!.length * 46
                    : 60,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: progressBar,
                ),
              ),
            ),
            const SizedBox(width: 30),
            orderDetails,
          ],
        ),
      ],
    );
  }
}

class OrderProgressBar extends StatelessWidget {
  final double progress;
  final Color activeColor;
  final Color inActiveColor;

  OrderProgressBar({
    required this.progress,
    required this.activeColor,
    required this.inActiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: inActiveColor,
      color: activeColor,
    );
  }
}

class OrderDetails extends StatelessWidget {
  final List<TextDto>? details;
  final TextStyle subTitleStyle;
  final TextStyle subDateStyle;

  OrderDetails({
    this.details,
    required this.subTitleStyle,
    required this.subDateStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                details![index].title,
                style: subTitleStyle,
              ),
              const SizedBox(height: 4),
              Text(
                details![index].date,
                style: subDateStyle,
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 4);
        },
        itemCount: details != null && details!.isNotEmpty ? details!.length : 0,
      ),
    );
  }
}

class TextDto {
  final String title;
  final String date;

  TextDto(this.title, this.date);
}

enum Status { order, shipped, outOfDelivery, delivered }
