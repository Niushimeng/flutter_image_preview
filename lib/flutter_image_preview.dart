library flutter_image_preview;
import 'package:flutter/material.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// A Calculator.
class ImagePreviewWidget extends StatefulWidget{
  final List<Widget> images;
  final String title;
  final Color _background;
  final TextStyle _titleStyle;
  final bool showTitle;

  ImagePreviewWidget({
    Key key,
    @required this.images,
    this.title = '预览',
    Color background,
    TextStyle titleStyle,
    this.showTitle = true,
  })
      : assert(images != null && images.length > 0),
        _titleStyle = TextStyle(color: Colors.white).merge(titleStyle),
        _background = background ?? Colors.black,
        super(key: key);
  @override
  _ImagePreviewState createState () => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreviewWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showTitle ? AppBar(
        title: Text(
          widget.title,
          style: widget._titleStyle,
        ),
        backgroundColor: widget._background,
      ) : null,
      backgroundColor: widget._background,
      body: SafeArea(
          child: Center(
            child: widget.images.length > 1 ? Swiper(
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return PinchZoomImage(image: widget.images.elementAt(index));
              },
              pagination: SwiperPagination(),
            ) : PinchZoomImage(image: widget.images.first,),
          )
      ),
    );
  }
}


class ImagePreview {
  static Future showImagePreview (BuildContext context, {
    @required List<Widget> images,
    String title = '预览',
    Color background,
    TextStyle titleStyle,
    bool showTitle = true
  }) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImagePreviewWidget(
              images: images,
              title: title,
              background: background,
              titleStyle: titleStyle,
              showTitle: showTitle,
            )
        )
    );
  }
}
