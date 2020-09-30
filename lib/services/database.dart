import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

// Database services class for handling general database
// purposes like data storing, loading etc....
class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseService.fromUID(this.uid);
  DatabaseService.toCollection(this.collectionRef);

  String uid;
  String collectionRef;

  // Load logged user details from database
  Future<Map<String, String>> loadUserDetails() async {
    Map<String, String> _details = {};

    await _firestore.collection('users').doc(uid).get().then((snap) {
      _details['name'] = snap.get('name');
    });

    return _details;
  }

  // Store data in database to collection provided
  // by (collectionRef) variable
  Future<void> storeData(Map<String, String> data) async {
    await _firestore.collection(collectionRef).add(data);
  }
}
