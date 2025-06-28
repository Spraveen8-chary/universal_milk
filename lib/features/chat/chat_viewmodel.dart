import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChatMessage {
  final String id;
  final String text;
  final bool isFromUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isFromUser,
    required this.timestamp,
  });
}

class ChatViewModel extends BaseViewModel {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  TextEditingController get messageController => _messageController;
  List<ChatMessage> get messages => _messages;

  // Simulated admin responses
  final List<String> _adminResponses = [
    "Hello! How can I help you today?",
    "Thank you for your message. I'll check your subscription status right away.",
    "Your next delivery is scheduled for tomorrow morning between 6am-8am.",
    "I've updated your delivery schedule as requested.",
    "The payment has been confirmed. Thank you!",
    "Is there anything else I can help you with?",
    "We have a special offer on our premium milk this week. Would you be interested?",
    "I'll send someone to address this issue immediately.",
  ];

  void initialize() {
    // In a real app, this would fetch previous messages from a service
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: "Hi there! How can we help you with your milk delivery today?",
        isFromUser: false,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isFromUser: true,
      timestamp: DateTime.now(),
    );

    _messages.insert(0, userMessage);
    _messageController.clear();
    notifyListeners();

    // Simulate typing delay
    setBusy(true);
    await Future.delayed(const Duration(seconds: 1));

    // Add admin response
    final adminMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: _getRandomAdminResponse(),
      isFromUser: false,
      timestamp: DateTime.now(),
    );

    _messages.insert(0, adminMessage);
    setBusy(false);
  }

  String _getRandomAdminResponse() {
    // In a real app, this would be handled by a chat service or API
    return _adminResponses[DateTime.now().second % _adminResponses.length];
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
