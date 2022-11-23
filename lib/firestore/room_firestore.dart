import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_talk_app/firestore/user_firestore.dart';
import 'package:firebase_talk_app/model/user.dart';
import 'package:firebase_talk_app/utils/shared_prefes.dart';
import '../model/talk_room.dart';

class RoomFirestore{
  static final FirebaseFirestore _firestoreFirestoreInstance = FirebaseFirestore.instance;
  static final _roomCollection = _firestoreFirestoreInstance.collection('room');
  static final joindRoomCollection = _roomCollection.where('joind_user_ids', arrayContains: SharedPrefs.fetchUid()).snapshots();


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

  //　自分が参加しているルームを取得
  static Future<List<TalkRoom>?> fetchJoinedRooms(QuerySnapshot snapshot) async {
    try {
      String myUid = SharedPrefs.fetchUid()!;
      List<TalkRoom> talkRooms = [];
      for(var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<dynamic> userIds = data['joind_user_ids'];
        late String talkUserUid;
        for (var userId in userIds) {
          if (userId != myUid) {
            talkUserUid = userId;
          }
        }
        print(talkUserUid);
        User? talkUser = await UserFirestore.fetchProfile(talkUserUid);
        if (talkUser == null) return null;
        final talkRoom = TalkRoom(
          roomId: doc.id,
          talkUser: talkUser,
          lastMessage: data['last_message'],
        );
        print(talkRooms.length);
        talkRooms.add(talkRoom);
      }
      return talkRooms;
    } catch (e) {
      print("Error fetching room $e");
      return null;
    }
  }

  static Stream<QuerySnapshot> fetchMessageSnapshot(String roomId) {
    return _roomCollection.doc(roomId).collection('message').orderBy('send_time', descending: true).snapshots();
  }
}