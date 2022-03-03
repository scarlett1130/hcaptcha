library hcaptcha;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

String? _initialUrl, _siteKey;

class HCaptcha {
  static init({String? initialUrl, String? siteKey}) {
    _initialUrl = initialUrl;
    _siteKey = siteKey;
  }

  static Future<Map?> show(BuildContext context) async {
    if (_initialUrl == null && _siteKey == null) {
      throw Exception(
          'hCaptcha not yet initialized. Initialize it with siteKey or initialUrl');
    }

    return Navigator.push<Map>(
      context,
      MaterialPageRoute(
        builder: (context) => const HCaptchaScreen(),
      ),
    );
  }
}

class HCaptchaScreen extends StatefulWidget {
  const HCaptchaScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HCaptchaState();
}

class HCaptchaState extends State<HCaptchaScreen> {
  WebViewController? webViewController;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: WebView(
      initialUrl: _initialUrl ??
          'https://api.ensorta.com/public/hcaptcha/index.html?siteKey=$_siteKey',
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>{
        JavascriptChannel(
            name: 'Captcha',
            onMessageReceived: (JavascriptMessage message) {
              // https://docs.hcaptcha.com/#server
              Navigator.of(context).pop({
                'code': message.message,
              });
            })
      },
      onWebViewCreated: (WebViewController w) {
        webViewController = w;
      },
    ));
  }
}
