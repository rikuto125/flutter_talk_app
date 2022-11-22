import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_talk_app/firestore/user_firestore.dart';
import 'package:firebase_talk_app/model/user.dart';

class RoomFirestore{
  static final FirebaseFirestore _firestoreFirestoreInstance = FirebaseFirestore.instance;
  static final _roomCollection = _firestoreFirestoreInstance.collection('room');

  static Future<void> createRoom(String myUid) async {
    try {
      final docs = await UserFirestore.fetchUser();
      if (docs == null) return;
      docs.forEach((doc) async {
        if (doc.id == myUid) return;
        await _roomCollection.add({
          'joind_user_ids': [myUid, doc.id],
          'created_time': Timestamp.now(),
        });
      });
    } catch (e) {
      print("Error creating room $e");
    }
  }
}