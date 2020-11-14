import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FullImageScreen extends StatelessWidget {
  FullImageScreen(this._image);

  final String _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: CachedNetworkImage(
              imageUrl: _image,
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      strokeWidth: 3.5,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) => Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.error,
                  size: 40,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45, left: 15),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 28,
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
