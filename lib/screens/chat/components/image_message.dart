import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:anonymous_chat/models/message.dart';
import 'package:anonymous_chat/screens/full_sized_image.dart';

// This is the image message widget
class ImageMessage extends StatelessWidget {
  const ImageMessage(this.messageData, this.isMe);

  final Message messageData;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                messageData.fromName,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullImageScreen(messageData.text),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: messageData.text,
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
          ),
        ],
      ),
    );
  }
}
