import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '/lang/l.dart';
import '/model/message.dart';

class ChatController extends GetxController {
  RxList<Message> listMesagge = <Message>[].obs;
  RxBool isSending = false.obs;

  static const String _apiKey = 'AIzaSyCBprD04b_UamnQ1iuRjYmBGWuCgQ9C67A';
  static const String _endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  Future<void> sendMessageToGemini(String message) async {
    isSending.value = true;

    try {
      // 1) Build contents từ lịch sử + câu mới (role: user/model)
      final contents = <Map<String, dynamic>>[
        ...listMesagge.map((m) => {
              // Google chấp nhận role 'user' và 'model'
              'role': m.isBot ? 'model' : 'user',
              'parts': [
                {'text': m.content}
              ],
            }),
        {
          'role': 'user',
          'parts': [
            {'text': message}
          ]
        }
      ];

      // 2) Request body (có thể thêm generationConfig nếu muốn)
      final body = jsonEncode({
        'contents': contents,
        // 'generationConfig': {
        //   'temperature': 0.7,
        //   'maxOutputTokens': 2048,
        //   'topP': 0.95,
        //   'topK': 40
        // }
      });

      final res = await http.post(
        Uri.parse(_endpoint),
        headers: {
          'x-goog-api-key': _apiKey,
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(utf8.decode(res.bodyBytes));
        final reply = _extractText(data) ??
            "Xin lỗi, mình chưa thể trả lời nội dung này.";
        listMesagge.add(Message(content: reply, isBot: true));
      } else {
        listMesagge.add(Message(
          content: "Đã có lỗi xảy ra vui lòng thử lại sau!",
          isBot: true,
        ));
      }
    } catch (e) {
      listMesagge.add(Message(
        content: "Đã có lỗi xảy ra vui lòng thử lại sau!",
        isBot: true,
      ));
    } finally {
      isSending.value = false;
    }
  }

  // Tách text từ candidates -> content -> parts[*].text
  String? _extractText(Map<String, dynamic> data) {
    final candidates = data['candidates'];
    if (candidates is List && candidates.isNotEmpty) {
      final content = candidates[0]['content'];
      if (content is Map) {
        final parts = content['parts'];
        if (parts is List && parts.isNotEmpty) {
          // Gộp mọi phần text nếu có
          final texts = parts
              .map((p) => p is Map ? p['text'] : null)
              .whereType<String>()
              .toList();
          if (texts.isNotEmpty) return texts.join('');
        }
      }
    }
    return null;
  }

  void resetChat() {
    listMesagge.clear();
    listMesagge.add(Message(content: L.helloChatBot.tr, isBot: true));
  }
}
