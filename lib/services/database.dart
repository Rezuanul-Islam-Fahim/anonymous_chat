import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

// Database services class for handling all general database
// purposes like data storing, loading
class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseService.userId(this.uid);

  DatabaseService.toCollection(this.collectionRef);

  String uid;
  String collectionRef;

  // Store user data in database
  Future<void> storeUser(Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).set(data);
  }

  // Load logged user details from database
  Future<Map<String, dynamic>> getUserData() async {
    Map<String, dynamic> _userDetails = {};
    QuerySnapshot _userSnapshot = await _firestore
        .collection('users')
        .where(
          'id',
          isEqualTo: uid,
        )
        .get();
    DocumentSnapshot _userDoc = _userSnapshot.docs[0];

    _userDetails['name'] = _userDoc.get('name');
    _userDetails['email'] = _userDoc.get('email');

    return _userDetails;
  }

  // Store data in database to collection provided
  // by (collectionRef) variable
  Future<void> storeData(Map<String, dynamic> data) async {
    await _firestore.collection(collectionRef).add(data);
  }
}
