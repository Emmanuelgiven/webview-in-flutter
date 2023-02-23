// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
            //stay in app
            return false;
          } else {
            controller.clearCache();
            CookieManager().clearCookies();
            //Leave app
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.white,
          ),
          body: WebView(
            initialUrl: 'https://digbit.tech',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              this.controller = controller;
              // controller.evaluateJavascript(
              //     "document.getElementsByTagName('header')[0].style.display='none'");
            },
          ),
        ),
      ),
    );
  }
}
