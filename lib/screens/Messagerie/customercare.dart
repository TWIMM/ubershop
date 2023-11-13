import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Itine/UseridProvider.dart'; // Replace with the correct path
import 'package:Itine/components/coustom_bottom_nav_bar.dart';
import 'package:Itine/enums.dart';

class ChatDetailPageWrapper extends StatefulWidget {
  static String routeName = '/messenger';

  @override
  _ChatDetailPageWrapperState createState() => _ChatDetailPageWrapperState();
}

class _ChatDetailPageWrapperState extends State<ChatDetailPageWrapper> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Use a delay to ensure the initialization happens after the build cycle
    Future.delayed(Duration.zero, () {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.initializeChat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChatDetailPage();
  }
}

class ChatDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Customer Service"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: userProvider.messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 70),
                  itemBuilder: (context, index) {
                    final message = userProvider.messages[index];
                    return Column(
                      crossAxisAlignment:
                          message.messageType == 'custumerclient'
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Align(
                            alignment: message.messageType == 'custumerclient'
                                ? Alignment.topLeft
                                : Alignment.topRight,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: message.messageType == 'user'
                                    ? Colors.grey.shade200
                                    : Color.fromARGB(255, 248, 190, 222),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    message.messageContent,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 7, 7, 7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (message.actions != null)
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: message.actions
                                  .map<Widget>((action) => ElevatedButton(
                                        onPressed: () {
                                          userProvider
                                              .handleAction(action['value']);
                                        },
                                        child: Text(action['title']),
                                      ))
                                  .toList(),
                            ),
                            width: 300,
                          ),
                      ],
                    );
                  },
                ),
              ),
              /*  Container(
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: "Write a message...",
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
                        userProvider.addMessage(messageController.text, 'user');
                        messageController.clear();
                      },
                    ),
                  ],
                ),
              ), */
            ],
          ),
          bottomNavigationBar:
              CustomBottomNavBar(selectedMenu: MenuState.profile),
        );
      },
    );
  }
}
