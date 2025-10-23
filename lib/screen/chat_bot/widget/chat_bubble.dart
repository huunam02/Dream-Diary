import '/config/global_color.dart';
import '/model/message.dart';
import 'chat_bubble_custom.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  final Message message;
  const MessageBubble({super.key, required this.message});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return MessageBubbleCustom(
      margin: const EdgeInsets.only(bottom: 16.0),
      leading: Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: ClipOval(
          child: Image.asset(
            "assets/images/ai_chat.png",
            width: 32,
            height: 32,
          ),
        ),
      ),
      text: widget.message.content,
      isSender: widget.message.isBot ? false : true,
      color: widget.message.isBot
          ? GlobalColors.linearContainer2
          : GlobalColors.linearPrimary2,
      tail: false,
      // sent: true,
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}
