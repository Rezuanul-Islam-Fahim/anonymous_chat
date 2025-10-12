import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:anonymous_chat/models/user.dart';
import 'package:anonymous_chat/models/message.dart';

// Database service class for handling all general database
// purposes like data storing, loading
class DatabaseService {
  DatabaseService.userId(this.uid);

  DatabaseService.toCollection(this.collectionRef);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? uid;
  String? collectionRef;

  // Store user data in database
  Future<void> storeUser(UserM userData) async {
    await firestore.collection('users').doc(uid).set({
      'id': userData.id,
      'name': userData.name,
      'email': userData.email,
    });
  }

  // Load logged user details from database
  Future<UserM> getUserData() async {
    QuerySnapshot userSnapshot = await firestore
        .collection('users')
        .where(
          'id',
          isEqualTo: uid,
        )
        .get();
    DocumentSnapshot userDoc = userSnapshot.docs[0];

    return UserM(
      id: userDoc.get('id'),
      name: userDoc.get('name'),
      email: userDoc.get('email'),
    );
  }

  // Store message in database to collection provided
  // by (collectionRef) variable
  Future<void> storeMessage(Message messageData) async {
    await firestore.collection(collectionRef!).add({
      'text': messageData.text,
      'fromName': messageData.fromName,
      'fromEmail': messageData.fromEmail,
      'timendate': messageData.timendate,
      'isImage': messageData.isImage,
    });
  }
}
