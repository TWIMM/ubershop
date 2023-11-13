import 'package:flutter/material.dart';
import 'package:uber/ApiCall/ReqHandler.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({
    required this.messageContent,
    required this.messageType,
  });
}

class UserProvider with ChangeNotifier {
  final CategorieService categorieService = CategorieService();
  int user_id = 0; // Initialize with an empty string
  List<ChatMessage> messages = [
    ChatMessage(
      messageContent:
          'Bienvenu sur Itine , \n veuillez laisser votre message\n le service client se chargera de répondre.',
      messageType: 'custumerclient',
    ),
  ]; // List to hold messages

  int get newUserId => user_id;

  void setUserId(int newUserId) {
    user_id = newUserId;
    fetchMessages();
    notifyListeners();
  }

  Future<void> fetchMessages() async {
    var response = await categorieService.getusermessage(user_id);
    if (response != null) {
      List<ChatMessage> fetchedMessages = [];
      for (var msg in response) {
        fetchedMessages.add(ChatMessage(
          messageContent: msg['messageContent'],
          messageType: msg['messageType'],
        ));
      }
      messages = fetchedMessages;
      notifyListeners();
    }
  }

  Future<void> sendMessage(String messageContent, String messageType) async {
    // Assuming the user_id is already available within the provider
    var response = await categorieService.createusermessage(
        messageContent, messageType, user_id);

    if (response == false) {
      // If the message was successfully added to the database
      addMessage(ChatMessage(
        messageContent: messageContent,
        messageType: messageType,
      ));
    }
  }

  void addMessage(ChatMessage message) {
    messages.add(message);
    notifyListeners();
  }
}
