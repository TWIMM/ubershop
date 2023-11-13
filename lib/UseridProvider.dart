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
  List messages = []; // List to hold messages

  int get newUserId => user_id;

  void setUserId(int newUserId) {
    user_id = newUserId;
    fetchMessages();
    notifyListeners();
  }

  Future<void> fetchMessages() async {
    var response = await categorieService.getusermessage(user_id);
    if (response != null) {
      messages = response;
      notifyListeners();
    }
  }

  Future<void> sendMessage(String messageContent, String messageType) async {
    // Assuming the user_id is already available within the provider
    var response = await categorieService.createusermessage(
        messageContent, messageType, user_id);

    if (response == false) {
      // If the message was successfully added to the database
      fetchMessages();
    }
  }
}
