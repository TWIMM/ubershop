import 'package:flutter/material.dart';
import 'package:Itine/ApiCall/ReqHandler.dart';
import "package:Itine/models/Product.dart";

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
  List livreur_delivery_start = [];
  List livreur_delivery_over = [];
  List livreur_delivery__encours = [];
  List<Map<String, dynamic>> categories = [];
  bool isLoading = false;
  var responseCount = 0;
  List<Product> popularProducts = [];

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
            'title': 'Faq 4',
            'value': 'faq4',
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
        addMessage('This is the response for FAQ 4', 'custumerclient');
      } else if (actionValue == 'faq4') {
        addMessage('This is the response for FAQ 4', 'custumerclient');
      }
      // Add more else-if conditions for each action as needed
    });
  }

  void setUserId(int newUserId) {
    user_id = newUserId;

    notifyListeners();
  }

  void setUserDelivery(List start, List over, List en_cours) {
    livreur_delivery_start = start;
    livreur_delivery_over = over;
    livreur_delivery__encours = en_cours;
    notifyListeners();
  }

  void addMessage(String messageContent, String messageType) {
    final newMessage = ChatMessage(
        messageContent: messageContent, messageType: messageType, actions: []);
    messages.add(newMessage);
    notifyListeners();
  }

  Future<void> loadCategories() async {
    if (categories.isEmpty) {
      try {
        isLoading = true;

        dynamic response = await categorieService.getCategories();
        categories = List<Map<String, dynamic>>.from(response);
      } catch (e) {
        print('Error loading categories: $e');
      } finally {
        isLoading = false;
        notifyListeners(); // Inform listeners about the change
      }
    }
  }

  Future<int> loadCount(category_id) async {
    if (responseCount == 0) {
      responseCount = await categorieService.getcount(category_id);
      notifyListeners(); // Inform listeners about the change
    }
    return responseCount;
  }

  Future<void> fetchPopularProducts() async {
    var response = await categorieService.getproducts();
    print(response);
    popularProducts =
        List<Map<String, dynamic>>.from(response).map((productMap) {
      return Product(
        id: productMap["id"] as int,
        images: List<String>.from(productMap["images_names"]),
        colors: productMap["availaible_colors"].map((hexString) {
          int colorInt = int.parse(hexString.substring(2), radix: 16);
          return Color(colorInt);
        }).toList(),
        title: productMap["label"],
        price: productMap["price"],
        description: productMap["description"],
        rating: 4.1,
        isFavourite: false,
        isPopular: false,
      );
    }).toList();

    notifyListeners();
  }
}
