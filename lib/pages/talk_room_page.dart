import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_talk_app/firestore/room_firestore.dart';
import 'package:firebase_talk_app/model/talk_room.dart';
import 'package:firebase_talk_app/utils/shared_prefes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../model/message.dart';

class TalkRoomPage extends StatefulWidget {
  //受け取る内容を定義(引数的なもの)
  final TalkRoom talkRoom;
  //受け取った内容を変数に格納
  const TalkRoomPage(this.talkRoom, {Key? key}) : super(key: key);

  @override
  State<TalkRoomPage> createState() => _TalkRoomPageState();
}

class _TalkRoomPageState extends State<TalkRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        //widgetを使用する理由
        //本来_TalkRoomPageStateとTalkRoomPageは別クラスなのでfinal String title;は _TalkRoomPageStateでは使えない
        //StatefulWidgetの中で定義した変数を使用したい
        //widget.titleでTalkRoomPageの中のtitleを使用できる
        title: Text(widget.talkRoom.talkUser.name),
      ),
      body: Stack(
        //alignment: Alignment.bottomCenter,
        children : [
          //メッセージ画面
          StreamBuilder<QuerySnapshot>(
            stream: RoomFirestore.fetchMessageSnapshot(widget.talkRoom.roomId),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 60),//スクロールした時に入力欄が隠れないようにする　height: 60は入力欄の高さ(containerの高さ)
                  child: ListView.builder(
                      physics: const RangeMaintainingScrollPhysics(), // トーク量が多くなった時にスクロールできるようにする
                      shrinkWrap: true, //トークが少ないときにスクロールバーが出てしまうのを防ぐ
                      reverse: true, // 一番下にスクロールした状態で表示
                      itemCount: snapshot.data!.docs.length,//!はsnapshot.dataがnullじゃないことを保証している
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                        Message message = Message(
                          message: data['message'],
                          isMe: SharedPrefs.fetchUid() == data['sender_id'],
                          sendTime: data['send_time'],
                        );
                        return Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0, bottom: index == 0 ? 10 : 0),
                          child: Row(
                            textDirection: message.isMe
                                ? TextDirection.rtl //TextDirection.rtlとは右から左に表示するという意味
                                : TextDirection.ltr, //TextDirection.ltrとは左から右に表示するという意味
                            children: [
                              Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.6, // 画面の70%まで表示 文字が多い時には改行する
                                  ),
                                  decoration: BoxDecoration(
                                    color: message.isMe
                                        ? Colors.blue
                                        : Colors.green, //自分のメッセージなら青、相手のメッセージなら白
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  //margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  //color: messageList[index].isMe ? Colors.blue : Colors.green,BoxDecorationで色を指定をしないといけない
                                  child: Text(message.message)
                              ),
                              Text(intl.DateFormat('HH:mm').format(message.sendTime.toDate())),
                            ],
                          ),
                        );
                      }),
                );
              }else{
                return const Center(
                  child: Text('メッセージがありません'),
                );
              }
            }
          ),
          //入力欄
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.white,
                height: 60,
                child: Row(
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: 'メッセージを入力',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    )),
                    IconButton(onPressed: () {

                    },
                        icon: const Icon(Icons.send))
                  ]
                ),
              ),
              Container(
                color : Colors.white,
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          )
        ]
      )
    );
  }
}
