import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SingleArticle extends StatefulWidget {
  final String url;

  SingleArticle({Key? key, required this.url}) : super(key: key);

  @override
  _SingleArticleState createState() => _SingleArticleState();
}

class _SingleArticleState extends State<SingleArticle> {
  final List<String> displayNone = [
    "document.getElementById('navigation-sticky-wrapper').style.display='none';",
    "document.getElementsByClassName('penci-footer-social-media penci-lazy')[0].style.display='none';",
    "document.getElementById('widget-area').style.display='none';"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      //TODO tirar o header da página
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
