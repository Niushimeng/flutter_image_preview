import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class ImagePreviewWidget extends StatefulWidget{
  final List<ImageProvider> images;
  final int initIndex;
  final PreviewTheme _previewTheme;

  ImagePreviewWidget({
    Key key,
    @required this.images,
    Color background,
    this.initIndex = 0,
    PreviewTheme previewTheme,
  })
    : assert(images != null && images.length > 0),
      _previewTheme = previewTheme ?? PreviewTheme(),
      super(key: key);
  @override
  _ImagePreviewState createState () => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreviewWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget._previewTheme.appBar,
      backgroundColor: widget._previewTheme.background,
      body: SafeArea(
          child: Center(
            child: widget.images.length > 1
            ? Swiper.children(
                children: widget.images.map<Widget>((image){
                  return buildImage(image);
                }).toList(),
                pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(activeColor: widget._previewTheme.activeColor)
                ),
                index: widget.initIndex,
              )
            : buildImage(widget.images.first,),
          )
      ),
    );
  }

  Widget buildImage(ImageProvider image) {
    var media = MediaQuery.of(context);
    return ExtendedImage(
      image: image,
      mode: ExtendedImageMode.gesture,
      height: media.size.height,
      fit: BoxFit.scaleDown,
    );
  }
}


class ImagePreview {
  static Future showImagePreview (BuildContext context, {
    @required List<ImageProvider> images,
    int initIndex = 0,
    PreviewTheme previewTheme,
  }) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewWidget(
            images: images,
            initIndex: initIndex,
            previewTheme: previewTheme,
          )
        )
    );
  }
}


class PreviewTheme {
  String title;
  Color background;
  bool showTitle;
  AppBar appBar;
  Color activeColor;

  PreviewTheme({
    this.title = '预览', 
    this.background = Colors.black, 
    this.showTitle = true, 
    AppBar appBar, 
    this.activeColor = Colors.blue,
    }) : this.appBar = showTitle ? appBar ?? AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ) : null;
}