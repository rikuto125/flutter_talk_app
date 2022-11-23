
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_talk_app/firestore/room_firestore.dart';

import '../model/user.dart';
import '../utils/shared_prefes.dart';

class UserFirestore {
  static final FirebaseFirestore _firestoreFirestoreInstance = FirebaseFirestore.instance;
  static final _userCollection = _firestoreFirestoreInstance.collection('user');

  static Future<String?> insertNewAccount() async {
    try {
      final newDoc = await _userCollection.add({
        'name': 'test',
        'image_path': 'https://www.w3schools.com/w3css/img_lights.jpg',
      });

      print("User created");
      return newDoc.id;

    } catch (e) {
      print("Error creating user $e");
      return null;
    }
  }

  static Future<void> createUser() async{
    final myUid = await insertNewAccount();
    if(myUid != null) {
      await RoomFirestore.createRoom(myUid);
      await SharedPrefs.setUid(myUid);
    }
  }


  static Future<List<QueryDocumentSnapshot>?> fetchUser() async {
    try {
      final snapshot = await _userCollection.get();
       for (var doc in snapshot.docs) {
          print(doc.id);
        } //documentsを取得
      return snapshot.docs;
    } catch (e) {
      print("Error fetching user $e");
      return null;
    }
  }

  static Future<User?> fetchProfile(String uid) async{
    try {
      final snapShot = await _userCollection.doc(uid).get();
      User user = User(
        name: snapShot.data()!['name'],
        imagePath: snapShot.data()!['image_path'],
        uid: uid,
      );
      print(user);
      return user;
    }catch (e) {
      print("Error fetching user $e");
      return null;
    }
  }

}
