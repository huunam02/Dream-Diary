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
          "https://firebasestorage.googleapis.com/v0/b/asa189-dream-journal.appspot.com/o/Privacy-Policy.html?alt=media&token=aa1e835d-7bc4-43a4-a20b-cca415a06772"));
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
