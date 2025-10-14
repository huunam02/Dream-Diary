import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        onPageStarted: (url) {},
        onPageFinished: (url) {},
        onHttpError: (error) {},
        onWebResourceError: (error) {},
      ))
      ..loadRequest(Uri.parse(
          "https://sites.google.com/view/privacypolicyfor-dreamdiary/trang-ch%E1%BB%A7"));
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }


  
}
