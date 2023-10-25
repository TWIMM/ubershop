import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomAlert {
  final String text;
  final BuildContext context;

  const CustomAlert({
    required this.text,
    required this.context,
  });

  static showalert(context, text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      CustomIcons.cancel_outlined,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              StyledText(
                text: text,
                fontName: "Open Sans",
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomIcons {
  static const IconData add_circle_sharp =
      IconData(0xe74e, fontFamily: 'MaterialIcons');
  static const IconData done_all_outlined =
      IconData(0xefe5, fontFamily: 'MaterialIcons');
  static const IconData push_pin_sharp =
      IconData(0xebea, fontFamily: 'MaterialIcons');
  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');

  static const IconData warning_amber_rounded =
      IconData(0xf02a0, fontFamily: 'MaterialIcons');

  static const IconData account_circle_outlined =
      IconData(0xee35, fontFamily: 'MaterialIcons');
  static const IconData phone_rounded =
      IconData(0xf0083, fontFamily: 'MaterialIcons');
  static const IconData pin_drop =
      IconData(0xe4c7, fontFamily: 'MaterialIcons');
  static const IconData markunread_outlined =
      IconData(0xf1b8, fontFamily: 'MaterialIcons');
  static const IconData map_outlined =
      IconData(0xf1ae, fontFamily: 'MaterialIcons');
  static const IconData maps_home_work =
      IconData(0xe3c9, fontFamily: 'MaterialIcons');
  static const IconData home_outlined =
      IconData(0xf107, fontFamily: 'MaterialIcons');

  static const IconData arrow_circle_left_outlined =
      IconData(0xf05bc, fontFamily: 'MaterialIcons');
  static const IconData arrow_circle_right_outlined =
      IconData(0xf05bd, fontFamily: 'MaterialIcons');

  static const IconData folder_open_outlined =
      IconData(0xf090, fontFamily: 'MaterialIcons');
  static const IconData search = IconData(0xe567, fontFamily: 'MaterialIcons');

  static const IconData shield_outlined =
      IconData(0xf379, fontFamily: 'MaterialIcons');
  static const IconData diversity_2_sharp =
      IconData(0xf0839, fontFamily: 'MaterialIcons');
  static const IconData radio_button_on_outlined =
      IconData(0xf2e5, fontFamily: 'MaterialIcons');
  static const IconData send_outlined =
      IconData(0xf355, fontFamily: 'MaterialIcons', matchTextDirection: true);
  static const IconData sms_outlined =
      IconData(0xf3ad, fontFamily: 'MaterialIcons');
  static const IconData home = IconData(0xe318, fontFamily: 'MaterialIcons');
  static const IconData add = IconData(0xe047, fontFamily: 'MaterialIcons');
  static const IconData bookmarks_outlined =
      IconData(0xeee5, fontFamily: 'MaterialIcons');
}
