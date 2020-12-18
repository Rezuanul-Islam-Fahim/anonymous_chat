import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:anonymous_chat/models/user.dart';
import 'package:anonymous_chat/models/message.dart';
import 'package:anonymous_chat/services/database.dart';
import 'package:anonymous_chat/components/circular_loader.dart';
import 'package:anonymous_chat/screens/chat/components/appbar.dart';
import 'package:anonymous_chat/screens/chat/components/message_stream.dart';
import 'package:anonymous_chat/screens/chat/components/send_area.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController messageScroll = ScrollController();
  UserM userData;
  int msgLimit = 15;
  int msgIncrement = 20;
  bool isLoading = false;

  // Load user-details handler
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userData = UserM(
        name: prefs.getString('name'),
        email: prefs.getString('email'),
      );
    });
  }

  // Message scroll listener
  void scrollListener() {
    if (messageScroll.offset >= messageScroll.position.maxScrollExtent &&
        !messageScroll.position.outOfRange) {
      setState(() => msgLimit += msgIncrement);
    }
  }

  // This handler is used for storing message to database
  Future<void> sendMessage() async {
    if (messageController.text.length > 0) {
      // Store message to a new variable for performance improvement
      String message = messageController.text;

      // Clear text field before storing message
      messageController.clear();

      // // Store message
      DatabaseService.toCollection('messages').storeMessage(
        Message(
          text: message,
          fromName: userData.name,
          fromEmail: userData.email,
          timendate: DateTime.now().toIso8601String(),
          isImage: false,
        ),
      );
    }
  }

  // This handler is used for storing image message to database
  Future<void> sendImage() async {
    // Pick an image
    PickedFile pickedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      // Enable the loader when sending image
      setState(() => isLoading = true);

      File image = File(pickedImage.path);
      StorageReference storageRef = FirebaseStorage.instance.ref().child(
            '${DateTime.now().millisecondsSinceEpoch}',
          );
      StorageUploadTask uploadTask = storageRef.putFile(image);
      StorageTaskSnapshot taskSnap = await uploadTask.onComplete;

      taskSnap.ref.getDownloadURL().then((imgUrl) async {
        // Store image message to database
        DatabaseService.toCollection('messages').storeMessage(
          Message(
            text: imgUrl,
            fromName: userData.name,
            fromEmail: userData.email,
            timendate: DateTime.now().toIso8601String(),
            isImage: true,
          ),
        );
      });

      // Disable the loader when image successfully stored
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();

    // Load logged user data
    loadUserData();

    // Messages listview builder's scroll listener
    messageScroll.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, userData),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              MessageStream(userData, messageScroll, msgLimit),
              SendArea(messageController, sendMessage, sendImage),
            ],
          ),
          if (isLoading) const Loader('Sending...'),
        ],
      ),
    );
  }
}
