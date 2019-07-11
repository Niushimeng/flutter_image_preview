import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:extended_image/extended_image.dart';
import 'image_preview.dart';

const channelName = 'ImageClick';

class ImagePreviewWebview extends StatefulWidget {
  final String url;
  final Widget loading;
  final Map<String, String> headers;

  ImagePreviewWebview({this.url, this.loading, this.headers});

  @override
  _ImagePreviewWebviewState createState() => _ImagePreviewWebviewState();
}

class _ImagePreviewWebviewState extends State<ImagePreviewWebview> {
  Set<JavascriptChannel> _channels;
  bool loading = true;
  WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _channels = Set();
    _channels.add(JavascriptChannel(
        name: channelName, onMessageReceived: onImageTap));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: _channels,
          onWebViewCreated: onWebViewCreated,
          onPageFinished: (String url) {
            setImageTapListener(_controller);
          },
        ),
        widget.loading ?? CircularProgressIndicator(),
      ],
    );
  }

  void onWebViewCreated(WebViewController controller) async {
    _controller = controller;
    await controller.loadUrl(
      widget.url,
      headers: widget.headers,
    );
    setState(() {
      loading = false;
    });
  }


  void setImageTapListener(WebViewController controller) {
    controller.evaluateJavascript("""
    (function () {
        var imageNodes = document.getElementsByTagName('img');
        var images = [];
        for (var i in imageNodes) {
            var image = imageNodes.item(i);
            if (image.src) {
              image.onclick = function(e) {
                  ImageClick.postMessage(JSON.stringify({
                      images: images,
                      index: images.indexOf(e.target.src),
                  }));
              }
              images.push(image.src);
            }
        }
    })();
    """);
  }

  void onImageTap(JavascriptMessage msg) {
    Map<String, dynamic> message = json.decode(msg.message);
    int index = message['index'] as int;
    List images = message['images'];
    ImagePreview.showImagePreview(
      context,
      images: images.map<ImageProvider>((image) {
        return ExtendedNetworkImageProvider(
          image,
          cache: true,
        );
      }).toList(),
      initIndex: index,
    );
  }
}