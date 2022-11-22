import 'package:firebase_talk_app/pages/setting_profile_page.dart';
import 'package:firebase_talk_app/pages/talk_room_page.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<User> userList = [
    User(name: "田中", uid: "1234567890", imagePath: "https://www.google.com/imgres?imgurl=https%3A%2F%2Fassets.st-note.com%2Fproduction%2Fuploads%2Fimages%2F58075596%2Fprofile_7d12166cbb91dd3ff25bbed3898bdd76.png%3Ffit%3Dbounds%26format%3Djpeg%26quality%3D85%26width%3D330&imgrefurl=https%3A%2F%2Fnote.com%2Fhatchoutschool&tbnid=2G_7dSjBxJnOQM&vet=12ahUKEwiTnIiL9cD7AhVWDN4KHVGfA_sQMygAegUIARCoAQ..i&docid=1CE0hJTAnKPpxM&w=330&h=330&q=flutter%20lab&ved=2ahUKEwiTnIiL9cD7AhVWDN4KHVGfA_sQMygAegUIARCoAQ", lastMessage: "こんにちは"),
    User(name:"佐藤", uid: "1234567891", imagePath: "https://www.google.com/imgres?imgurl=https%3A%2F%2Fassets.st-note.com%2Fproduction%2Fuploads%2Fimages%2F58075596%2Fprofile_7d12166cbb91dd3ff25bbed3898bdd76.png%3Ffit%3Dbounds%26format%3Djpeg%26quality%3D85%26width%3D330&imgrefurl=https%3A%2F%2Fnote.com%2Fhatchoutschool&tbnid=2G_7dSjBxJnOQM&vet=12ahUKEwiTnIiL9cD7AhVWDN4KHVGfA_sQMygAegUIARCoAQ..i&docid=1CE0hJTAnKPpxM&w=330&h=330&q=flutter%20lab&ved=2ahUKEwiTnIiL9cD7AhVWDN4KHVGfA_sQMygAegUIARCoAQ", lastMessage: "おはよう"),
    User(name:"佐藤", uid: "1234567891", imagePath: "https://www.google.com/imgres?imgurl=https%3A%2F%2Fassets.st-note.com%2Fproduction%2Fuploads%2Fimages%2F58075596%2Fprofile_7d12166cbb91dd3ff25bbed3898bdd76.png%3Ffit%3Dbounds%26format%3Djpeg%26quality%3D85%26width%3D330&imgrefurl=https%3A%2F%2Fnote.com%2Fhatchoutschool&tbnid=2G_7dSjBxJnOQM&vet=12ahUKEwiTnIiL9cD7AhVWDN4KHVGfA_sQMygAegUIARCoAQ..i&docid=1CE0hJTAnKPpxM&w=330&h=330&q=flutter%20lab&ved=2ahUKEwiTnIiL9cD7AhVWDN4KHVGfA_sQMygAegUIARCoAQ", lastMessage: "おはよう"),
  ];

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
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (BuildContext context, int index) {
          //InkWellを使うことで、タップすることができるようになる
          return InkWell(
            //onTapでタップしたら、TalkRoomPageに遷移する
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => TalkRoomPage(userList[index].name) //constがいらない理由は、userList[index].nameが変わる可能性があるから
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
                      backgroundImage: userList[index].imagePath == null
                          ? null
                          : NetworkImage(userList[index].imagePath!),
                      ),
                  ),//
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userList[index].name, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text(userList[index].lastMessage, style: TextStyle(fontSize: 15, color: Colors.grey),),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
