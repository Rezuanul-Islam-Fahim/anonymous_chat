import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:anonymous_chat/components/circular_loader.dart';
import 'package:anonymous_chat/screens/chat/components/appbar.dart';
import 'package:anonymous_chat/screens/chat/components/message_stream.dart';
import 'package:anonymous_chat/screens/chat/components/send_area.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _messageScroll = ScrollController();
  final int _msgIncrement = 20;
  Map<String, dynamic> _userData = {};
  int _msgLimit = 15;
  bool _isLoading = false;

  // Load user-details handler
  Future<void> _loadUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    setState(() {
      _userData['name'] = _prefs.getString('name');
      _userData['email'] = _prefs.getString('email');
    });
  }

  // Message scroll listener
  void _scrollListener() {
    if (_messageScroll.offset >= _messageScroll.position.maxScrollExtent &&
        !_messageScroll.position.outOfRange) {
      setState(() => _msgLimit += _msgIncrement);
    }
  }

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

  // This handler will store image to database
  Future<void> _sendImage() async {
    File image;
    PickedFile pickedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() => _isLoading = true);

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

      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _messageScroll.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, _userData),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              MessageStream(_userData, _messageScroll, _msgLimit),
              SendArea(_messageController, _sendMessage, _sendImage),
            ],
          ),
          if (_isLoading) Loader('Sending...'),
        ],
      ),
    );
  }
}
