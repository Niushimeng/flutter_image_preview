import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class ImagePreviewWidget extends StatefulWidget{
  final List<ImageProvider> images;
  final String title;
  final Color _background;
  final bool showTitle;
  final AppBar appBar;
  final int initIndex;

  ImagePreviewWidget({
    Key key,
    @required this.images,
    this.title = '预览',
    Color background,
    this.appBar,
    this.initIndex = 0,
    this.showTitle = true,
  })
    : assert(images != null && images.length > 0),
      _background = background ?? Colors.black,
      super(key: key);
  @override
  _ImagePreviewState createState () => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreviewWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showTitle ? widget.appBar ?? AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ) : null,
      backgroundColor: widget._background,
      body: SafeArea(
          child: Center(
            child: widget.images.length > 1
            ? Swiper.children(
                children: widget.images.map<Widget>((image){
                  return buildImage(image);
                }).toList(),
                pagination: SwiperPagination(

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
      mode: ExtendedImageMode.Gesture,
      height: media.size.height,
      fit: BoxFit.fitWidth,
    );
  }
}


class ImagePreview {
  static Future showImagePreview (BuildContext context, {
    @required List<ImageProvider> images,
    String title = '预览',
    Color background,
    AppBar appBar,
    bool showTitle = true,
    int initIndex = 0
  }) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImagePreviewWidget(
              images: images,
              title: title,
              background: background,
              showTitle: showTitle,
              appBar: appBar,
              initIndex: initIndex
            )
        )
    );
  }
}
