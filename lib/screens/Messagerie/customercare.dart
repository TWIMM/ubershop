import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber/UseridProvider.dart'; // Replace with the correct path

class ChatDetailPage extends StatelessWidget {
  static String routeName = '/messenger';

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Service client"),
          ),
          body: Container(
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: userProvider.messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (userProvider.messages[index].messageType ==
                                "custumerclient"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (userProvider.messages[index].messageType ==
                                    "user"
                                ? Colors.grey.shade200
                                : Color.fromARGB(255, 248, 190, 222)),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            userProvider.messages[index].messageContent,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: "Ecrivez un message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        FloatingActionButton(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                          backgroundColor: Color(0xFFFF1844),
                          elevation: 0,
                          onPressed: () {
                            userProvider.sendMessage(
                                messageController.text, 'user');
                            messageController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
