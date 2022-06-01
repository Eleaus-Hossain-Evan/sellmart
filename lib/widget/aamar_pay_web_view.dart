import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AamarPayWebView extends StatefulWidget {

  final url;

  AamarPayWebView(this.url);

  @override
  _AamarPayWebViewState createState() => _AamarPayWebViewState();
}

class _AamarPayWebViewState extends State<AamarPayWebView> {

  final Completer<InAppWebViewController> _completer = Completer<InAppWebViewController>();

  bool _isLoadingPage;

  @override
  void initState() {

    _isLoadingPage = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[

              InAppWebView(
                onWebViewCreated: (InAppWebViewController webViewController) {
                  _completer.complete(webViewController);
                },
                onLoadStart: (InAppWebViewController controller, String url) {

                  setState(() {
                    _isLoadingPage = true;
                  });

                  if(url.split('/').contains("confirm") || url.split('/').contains("cancel") || url.split('/').contains("fail")) {

                    Navigator.pop(context, url);
                  }
                },
                onProgressChanged: (InAppWebViewController controller, int url) {},
                onLoadStop: (InAppWebViewController controller, String url) {

                  setState(() {
                    _isLoadingPage = false;
                  });
                },
                initialUrl: '${widget.url}',
              ),

              _isLoadingPage ? Center(child: CircularProgressIndicator()) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
