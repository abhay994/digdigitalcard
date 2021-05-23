import 'dart:async';
import 'dart:io';
import 'package:digitalcard/exports.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewUrl extends StatefulWidget {
 final String? url;

  WebViewUrl({Key? key ,this.url}):super(key: key);
  @override
  WebViewUrlState createState() => WebViewUrlState();
}

class WebViewUrlState extends State<WebViewUrl> {

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onProgress: (int progress) {
          print("WebView is loading (progress : $progress%)");
        },

        initialUrl: widget.url,
      ),
    );
  }
}