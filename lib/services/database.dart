import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

// Database service class for handling all general database
// purposes like data storing, loading
class DatabaseService {
  DatabaseService.userId(this.uid);

  DatabaseService.toCollection(this.collectionRef);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid;
  String collectionRef;

  // Store user data in database
  Future<void> storeUser(Map<String, dynamic> data) async {
    await firestore.collection('users').doc(uid).set(data);
  }

  // Load logged user details from database
  Future<Map<String, dynamic>> getUserData() async {
    Map<String, dynamic> userDetails = {};
    QuerySnapshot userSnapshot = await firestore
        .collection('users')
        .where(
          'id',
          isEqualTo: uid,
        )
        .get();
    DocumentSnapshot userDoc = userSnapshot.docs[0];

    userDetails['name'] = userDoc.get('name');
    userDetails['email'] = userDoc.get('email');

    return userDetails;
  }

  // Store data in database to collection provided
  // by (collectionRef) variable
  Future<void> storeData(Map<String, dynamic> data) async {
    await firestore.collection(collectionRef).add(data);
  }
}
