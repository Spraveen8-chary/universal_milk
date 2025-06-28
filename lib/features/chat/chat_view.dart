import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:universal_milk/features/chat/chat_viewmodel.dart';
import 'package:universal_milk/shared/app_colors.dart';
import 'package:universal_milk/shared/button.dart';
import 'package:universal_milk/shared/text_style.dart';
import 'package:universal_milk/shared/ui_helpers.dart';

class ChatView extends StackedView<ChatViewModel> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChatViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Admin'),
        backgroundColor: kcPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Chat header with admin info
          Container(
            color: kcPrimaryColor.withOpacity(0.1),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: kcPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.support_agent,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin Support',
                        style: heading3Style(context),
                      ),
                      Text(
                        'Online | Typically replies within 10 minutes',
                        style: bodySmallStyle(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Chat messages
          Expanded(
            child: viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : viewModel.messages.isEmpty
                    ? _buildEmptyState(context)
                    : _buildChatMessages(context, viewModel),
          ),

          // Divider
          const Divider(height: 1),

          // Message input field
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: viewModel.messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => viewModel.sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: kcPrimaryColor,
                  radius: 24,
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: viewModel.sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: kcSecondaryColor,
            ),
            kSpaceMedium,
            Text(
              'Start a conversation',
              style: heading2Style(context),
              textAlign: TextAlign.center,
            ),
            kSpaceSmall,
            Text(
              'Chat with our admin for any support or questions about your milk delivery',
              style: bodyStyle(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatMessages(BuildContext context, ChatViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      reverse: true,
      itemCount: viewModel.messages.length,
      itemBuilder: (context, index) {
        final message = viewModel.messages[index];
        final isUser = message.isFromUser;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isUser) ...{
                CircleAvatar(
                  backgroundColor: kcPrimaryColor.withOpacity(0.2),
                  child: const Icon(
                    Icons.support_agent,
                    color: kcPrimaryColor,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
              },
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isUser ? kcPrimaryColor : kcCreamColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: isUser ? Colors.white : kcPrimaryTextColor,
                    ),
                  ),
                ),
              ),
              if (isUser) const SizedBox(width: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  ChatViewModel viewModelBuilder(BuildContext context) => ChatViewModel();

  @override
  void onViewModelReady(ChatViewModel viewModel) => viewModel.initialize();
}
