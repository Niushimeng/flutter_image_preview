# flutter_image_preview
自己项目使用的一个图片预览组件，支持点击webview中的图片进行预览

## Getting Started

图片预览

import 'package:flutter_image_preview/flutter_image_preview.dart';
ImagePreview.showImagePreview(
    context, 
    images: <ImageProvider>[
        AssetImage(
        'assets/1.jpg',
        ),
        AssetImage(
        'assets/2.jpg',
        ),
        AssetImage(
        'assets/3.jpg',
        ),
    ]
);

点击webview中的图片进行预览

ImagePreviewWebview(
    url: 'https://home.biaosuzy.com/page/articles/1',
)







This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
