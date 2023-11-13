import 'package:flutter/material.dart';
import 'package:uber/ApiCall/ReqHandler.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  List actions;

  ChatMessage({
    required this.actions,
    required this.messageContent,
    required this.messageType,
  });
}

class UserProvider with ChangeNotifier {
  final CategorieService categorieService = CategorieService();
  int user_id = 0; // Initialize with an empty string
  List messages = []; // List to hold messages

  int get newUserId => user_id;
  void initializeChat() {
    if (messages.isEmpty) {
      // Only add initial message if the list is empty
      messages.add(ChatMessage(
        messageContent: 'Comment pouvons nous \n vous aider ??',
        messageType: 'custumerclient',
        actions: [
          {
            'title': 'Faq 1',
            'value': 'faq1',
          },
          {
            'title': 'Faq 2',
            'value': 'faq2',
          },
          {
            'title': 'Faq 3',
            'value': 'faq3',
          },
          {
            'title': 'Faq 2',
            'value': 'faq3',
          },
          // Add more actions/buttons as needed
        ],
      ));
      notifyListeners();
    }
  }

  void handleAction(String actionValue) {
    addMessage('User clicked: $actionValue', 'user');
    // Delay to simulate system response, replace this with your actual API call or business logic
    Future.delayed(Duration(seconds: 1), () {
      if (actionValue == 'faq1') {
        addMessage('This is the response for FAQ 1', 'custumerclient');
      } else if (actionValue == 'faq2') {
        addMessage('This is the response for FAQ 2', 'custumerclient');
      } else if (actionValue == 'faq3') {
        addMessage('This is the response for FAQ 3', 'custumerclient');
      }
      // Add more else-if conditions for each action as needed
    });
  }

  void setUserId(int newUserId) {
    user_id = newUserId;

    notifyListeners();
  }

  void addMessage(String messageContent, String messageType) {
    final newMessage = ChatMessage(
        messageContent: messageContent, messageType: messageType, actions: []);
    messages.add(newMessage);
    notifyListeners();
  }
}
