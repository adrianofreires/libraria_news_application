import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SingleArticle extends StatefulWidget {
  final String url, category;

  SingleArticle({Key? key, required this.url, required this.category})
      : super(key: key);

  @override
  _SingleArticleState createState() => _SingleArticleState();
}

class _SingleArticleState extends State<SingleArticle> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  final newKey = UniqueKey();
  int position = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image(
          image: AssetImage('assets/logo_news_bar.png'),
          width: 120,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share_outlined),
            onPressed: () {
              Share.share(widget.url);
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: position,
        children: [
          WebView(
            initialUrl: widget.url,
            key: widget.key,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) => _completer.complete(controller),
            onPageStarted: startLoading,
            onPageFinished: doneLoading,
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xffe82822),
              ),
            ),
          ),
        ],
      ),
    );
  }

  doneLoading(String A) async {
    (await _completer.future).evaluateJavascript(
        "document.getElementById('navigation-sticky-wrapper').style.display='none';");
    (await _completer.future).evaluateJavascript(
        "document.getElementsByClassName('penci-footer-social-media penci-lazy')[0].style.display='none';");
    (await _completer.future).evaluateJavascript(
        "document.getElementById('widget-area').style.display='none';");
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }
}
