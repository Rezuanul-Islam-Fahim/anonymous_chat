import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseService.fromUID(this.uid);
  DatabaseService.toCollection(this.collectionRef);

  String uid;
  String collectionRef;

  Future<Map<String, String>> loadUserDetails() async {
    Map<String, String> _details = {};

    await _firestore.collection('users').doc(uid).get().then((snap) {
      _details['name'] = snap.get('name');
    });
    return _details;
  }

  Future<void> storeData(Map<String, String> data) async {
    await _firestore.collection(collectionRef).add(data);
  }
}
