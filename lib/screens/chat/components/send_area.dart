import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:anonymous_chat/screens/chat/components/message_input_field.dart';

// Chat screen's widget for building send-area
class SendArea extends StatelessWidget {
  SendArea(this._userData);

  final Map<String, dynamic> _userData;
  final TextEditingController _messageController = TextEditingController();

  // This handler will be used for storing message to database
  Future<void> _sendMessage() async {
    if (_messageController.text.length > 0) {
      // Store message to a new variable
      String message = _messageController.text;

      // Clear text field before storing message
      _messageController.clear();

      // Store message
      await FirebaseFirestore.instance.collection('messages').add({
        'text': message,
        'fromName': _userData['name'],
        'fromEmail': _userData['email'],
        'timendate': DateTime.now().toIso8601String(),
        'isImage': false,
      });
    }
  }

  Future<void> _sendImage() async {
    File image;
    PickedFile pickedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      image = File(pickedImage.path);

      StorageReference storageRef = FirebaseStorage.instance.ref().child(
            '${DateTime.now().millisecondsSinceEpoch}',
          );
      StorageUploadTask uploadTask = storageRef.putFile(image);
      StorageTaskSnapshot taskSnap = await uploadTask.onComplete;

      taskSnap.ref.getDownloadURL().then((img) async {
        // Store message
        await FirebaseFirestore.instance.collection('messages').add({
          'text': img,
          'fromName': _userData['name'],
          'fromEmail': _userData['email'],
          'timendate': DateTime.now().toIso8601String(),
          'isImage': true,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 15, 10, 15),
      child: Row(
        children: <Widget>[
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.photo),
            iconSize: 28,
            splashRadius: 20,
            onPressed: _sendImage,
          ),
          MessageInputField(_messageController, _sendMessage),
          Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(30),
            elevation: 5,
            color: Theme.of(context).primaryColor,
            type: MaterialType.button,
            child: IconButton(
              icon: Icon(Icons.send),
              iconSize: 25,
              color: Colors.white,
              padding: EdgeInsets.all(12),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
