import 'package:flutter/material.dart';
import 'package:uber/ApiCall/ReqHandler.dart';
import 'package:provider/provider.dart';
import '../../UseridProvider.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({
    required this.messageContent,
    required this.messageType,
  });
}

class ChatDetailPage extends StatefulWidget {
  static String routeName = '/messenger';

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final CategorieService categorieService = CategorieService();
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> messages = [
    ChatMessage(
        messageContent: 'Bonjour que pouvons nous\n faire pour vous aider ? ',
        messageType: 'custumerclient')
  ];

  @override
  void initState() {
    super.initState();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int user_id = userProvider.user_id;
    getusermessage(user_id);
  }

  Future<void> sendMessage(
      String messageContent, String messageType, int user_id) async {
    var response = await categorieService.createusermessage(
        messageContent, messageType, user_id);
  }

  Future<void> getusermessage(int user_id) async {
    var response = await categorieService.getusermessage(user_id);
    if (response != null) {
      updateMessages(response);
    }
  }

  void updateMessages(List<dynamic> response) {
    setState(() {
      // messages.clear();
      messages.addAll(response.map((msg) => ChatMessage(
            messageContent: msg['messageContent'],
            messageType: msg['messageType'],
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    int user_id = userProvider.user_id;
    return Scaffold(
      appBar: AppBar(
        title: Text("Service client"),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "custumerclient"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType == "user"
                            ? Colors.grey.shade200
                            : Color.fromARGB(255, 248, 190, 222)),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        messages[index].messageContent,
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF1844),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                            hintText: "Ecrivez un méssage...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Color(0xFFFF1844),
                      elevation: 0,
                      onPressed: () {
                        if (messageController.text.isNotEmpty) {
                          messages.add(ChatMessage(
                            messageContent: messageController.text,
                            messageType: 'user',
                          ));
                          sendMessage(messageController.text, 'user', user_id);
                          messageController.clear();
                          setState(() {});
                        }
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
  }
}
