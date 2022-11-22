
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestore {
  static final FirebaseFirestore _firestoreFirestoreInstance = FirebaseFirestore.instance;
  static final _userCollection = _firestoreFirestoreInstance.collection('user');

  static Future<String?> createUser() async {
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

}
