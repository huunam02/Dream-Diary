import 'dart:convert';

import '/lang/l.dart';
import '/model/message.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  RxList<Message> listMesagge = <Message>[].obs;

  RxBool isSending = false.obs;

  Future<void> sendMessageToChatGPT(String message) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      'model': 'gpt-4',
      'messages': [
        {'role': 'user', 'content': message}
      ]
    });
    isSending.value = true;
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final chatResponse = data['choices'][0]['message']['content'];

        listMesagge.add(Message(content: chatResponse, isBot: true));
        isSending.value = false;
      } else {
        listMesagge.add(Message(
            content: "An error occurred, please try again!", isBot: true));
        isSending.value = false;
      }
    } catch (e) {
      listMesagge.add(Message(
          content: "An error occurred, please try again!", isBot: true));
      isSending.value = false;
    }
  }

  void resetChat() {
    listMesagge.clear();
    listMesagge.add(Message(content: L.helloChatBot.tr, isBot: true));
  }
}

const String apiKey =
    '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'; // Thay thế bằng API Key của bạn