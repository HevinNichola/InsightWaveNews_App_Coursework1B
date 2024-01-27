import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ArticleView extends StatefulWidget {
  final String blogUrl;
  const ArticleView({ Key? key, required this.blogUrl}) : super(key:key);


  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("InsightWave",
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                Text("News",
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )
              ],
            ),
            centerTitle: true,
            elevation: 0.0,
          ),
           body: WebView(
                        initialUrl: widget.blogUrl,
             javascriptMode: JavascriptMode.unrestricted,
             onWebViewCreated: (WebViewController webViewController){
                          _controller = webViewController;
             },
           ),
    );
  }
  @override
  void dispose(){
    _controller.clearCache();
    super.dispose();
  }
}
