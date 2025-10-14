
import 'package:dream_diary/base/lifecycle_state.dart';
import 'package:dream_diary/config/global_color.dart';

import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/model/message.dart';
import '/screen/chat/controller/chat_controller.dart';
import '/screen/chat/widget/chat_bubble.dart';
import '/screen/chat/widget/modalbottomsheet_detete.dart';
import '/screen/languege/controller/languege_controller.dart';
import '/screen/navbar/controller/navbar_controller.dart';
import '/util/view_ex.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChatAIScreen extends StatefulWidget {
  const ChatAIScreen({super.key});

  @override
  State<ChatAIScreen> createState() => _ChatAIScreenState();
}

class _ChatAIScreenState extends LifecycleState<ChatAIScreen> {
  final chatCtl = Get.find<ChatController>();
  final navbarCtl = Get.find<NavbarController>();
  final langCtl = Get.find<LanguageController>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  bool isValidChat = false;
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String mathText(String text) {
    return "Bạn là nhà giải nghĩa giấc mơ hãy trả lời câu hỏi: $text. bắt buộc phải trả lời bằng ngôn ngữ có mã iso là \"${langCtl.currentLang()}\"";
  }

  @override
  void initState() {
    super.initState();
    chatCtl.resetChat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _validateInput(String value) {
    String trimmedValue = value.replaceAll(' ', '');
    if (trimmedValue.isEmpty) {
      setState(() {
        isValidChat = false;
      });
    } else if (value.length > 100) {
      setState(() {
        isValidChat = false;
      });
    } else {
      setState(() {
        isValidChat = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BodyCustom(
        isShowBgImages: false,
        edgeInsetsPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 64.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    L.aiChat.tr,
                    style: GlobalTextStyles.font18w700ColorBlack,
                  ),
                  GestureDetector(
                    onTap: () {
                      tapAndCheckInternet(() {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ModalbottomsheetResetChatCustom(
                              ontapDelete: () {
                             
                                Get.back();
                                chatCtl.resetChat();
                              },
                              ontapCancel: () => Get.back(),
                            );
                          },
                        );
                      });
                    },
                    child: SvgPicture.asset(
                      "assets/icons/ic_reload.svg",
                      width: 24.0,
                      height: 24.0,
                      color: GlobalColors.linearPrimary1.colors.first,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Obx(
              () => ListView.builder(
                controller: _scrollController,
                itemCount: chatCtl.listMesagge.length,
                itemBuilder: (context, index) {
                  Message message = chatCtl.listMesagge[index];
                  return MessageBubble(
                    message: message,
                  );
                },
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  height: 44,
                  width: w * 0.8,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color:GlobalColors.linearContainer2.colors.first,
                      borderRadius: BorderRadius.circular(32.0)),
                  child: TextField(
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (value) {
                      _validateInput(value);
                    },
                    controller: _controller,
                    autofocus: false,
                    style: GlobalTextStyles.font14w400ColorBlack,
                    decoration: InputDecoration(
                      isCollapsed:
                          true, // Giảm padding mặc định trong InputDecoration
                      contentPadding: EdgeInsets
                          .zero, // Giảm khoảng cách trong InputDecoration
                      hintText: L.typeSomething.tr,
                      hintStyle: GlobalTextStyles.font14w400ColorBlackOp38,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (isValidChat) {
                      tapAndCheckInternet(() {
       
                        if (_controller.text.isNotEmpty) {
                          String? content = _controller.text;
                          chatCtl.listMesagge.add(
                              Message(content: _controller.text, isBot: false));
                          setState(() {
                            _controller.text = "";
                          });
                          _scrollToBottom();
                          chatCtl
                              .sendMessageToGemini(mathText(content))
                              .whenComplete(
                            () {
                              _scrollToBottom();
                            },
                          );
                        }
                      });
                    }
                  },
                  child: Obx(
                    () => chatCtl.isSending.value
                        ? const SizedBox(
                            height: 32.0,
                            width: 32.0,
                            child: CircularProgressIndicator(),
                          )
                        : SvgPicture.asset(
                            "assets/icons/ic_send.svg",
                            width: 32.0,
                            height: 32.0,color: Colors.blue,
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onKeyboardHint() {
    navbarCtl.setShow(true);
  }

  @override
  void onKeyboardShow() {
    navbarCtl.setShow(false);
  }

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
