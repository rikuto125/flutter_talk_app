import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_talk_app/firestore/room_firestore.dart';
import 'package:firebase_talk_app/pages/setting_profile_page.dart';
import 'package:firebase_talk_app/pages/talk_room_page.dart';
import 'package:flutter/material.dart';

import '../model/talk_room.dart';
import '../model/user.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const SettingProfilePage()
                ),);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: RoomFirestore.joindRoomCollection,
        builder: (context, streamSnapshot) {
          if(streamSnapshot.hasData){
            return FutureBuilder<List<TalkRoom>?>(
                future: RoomFirestore.fetchJoinedRooms(streamSnapshot.data!),
                builder: (context, futureSnapshot) {
                  if (futureSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }else{
                    if (futureSnapshot.hasData){
                      List<TalkRoom> talkRooms = futureSnapshot.data!;
                      print("talkRooms ${talkRooms.length}");
                      return ListView.builder(
                        itemCount: talkRooms.length,
                        itemBuilder: (context, index) {
                          //InkWellを使うことで、タップすることができるようになる
                          return InkWell(
                            //onTapでタップしたら、TalkRoomPageに遷移する
                            onTap: () {
                              //print("talkRooms ${talkRooms[index].roomId}");
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => TalkRoomPage(talkRooms[index])//constがいらない理由は、userList[index]が変わる可能性があるから
                              ));
                            },
                            child: SizedBox(
                              height: 70,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),//symmetric　左右に8pxの余白を作る verticalは上下に変わる
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: talkRooms[index].talkUser.imagePath == null
                                          ? null
                                          : NetworkImage(talkRooms[index].talkUser.imagePath!),
                                    ),
                                  ),//
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(talkRooms[index].talkUser.name, style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      Text(talkRooms[index].lastMessage ?? '', style: const TextStyle(fontSize: 15, color: Colors.grey),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  }else{
                      print("TalkRoomPageのFutureBuilderでエラーが発生しました");
                      return const Text("TalkRoomPageのFutureBuilderでエラーが発生しました");
                    }
                  }
                }
            );
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}
