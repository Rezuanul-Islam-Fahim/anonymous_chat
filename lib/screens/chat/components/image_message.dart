import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage(this._text, this._from, this._isMe);

  final String _text;
  final String _from;
  final bool _isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: _isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (!_isMe)
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Text(
                _from,
                style: TextStyle(fontSize: 13),
              ),
            ),
          if (!_isMe) SizedBox(height: 1),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: _text,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.grey[300],
                  child: Container(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      strokeWidth: 3,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) => Container(
                alignment: Alignment.center,
                color: Colors.grey[300],
                child: Icon(
                  Icons.error,
                  size: 40,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
