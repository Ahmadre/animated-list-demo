/* import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatefulWidget {
  final String imageURL;
  final String heroTag;

  ImageViewer({Key key, this.imageURL, this.heroTag}) : super(key: key);

  @override
  ImageViewerState createState() => ImageViewerState();
}

class ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoView(
        heroTag: widget.heroTag != null ? widget.heroTag : null,
        minScale: PhotoViewComputedScale.contained,
        imageProvider: NetworkImage(widget.imageURL),
        loadingChild: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
 */