import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../model/message.dart';

class TalkRoomPage extends StatefulWidget {
  //受け取る内容を定義(引数的なもの)
  final String name;
  //受け取った内容を変数に格納
  const TalkRoomPage(this.name, {Key? key}) : super(key: key);

  @override
  State<TalkRoomPage> createState() => _TalkRoomPageState();
}

class _TalkRoomPageState extends State<TalkRoomPage> {
  List<Message> messageList = [
    Message(message: "あいう", isMe: true, sentTime: DateTime(2021, 1,1, 12, 0)),
    Message(message: "かきく", isMe: false, sentTime: DateTime(2021, 1,1, 12, 1)),
    Message(message: "かきfさfさflさgjsかgkんさlgんsなsんgkんかslgんく", isMe: false, sentTime: DateTime(2021, 1,1, 12, 1)),
    Message(message: "あいう", isMe: true, sentTime: DateTime(2021, 1,1, 12, 0)),
    Message(message: "かきく", isMe: false, sentTime: DateTime(2021, 1,1, 12, 1)),
    Message(message: "かきfさfさflさgjsかgkんさlgんsなsんgkんかslgんく", isMe: false, sentTime: DateTime(2021, 1,1, 12, 1)),
    Message(message: "あいう", isMe: true, sentTime: DateTime(2021, 1,1, 12, 0)),
    Message(message: "かきく", isMe: false, sentTime: DateTime(2021, 1,1, 12, 1)),
    Message(message: "かきfさfさflさgjsかgkんさlgんsなsんgkんかslgんく", isMe: false, sentTime: DateTime(2021, 1,1, 12, 1)),
    Message(message: "あいう", isMe: true, sentTime: DateTime(2021, 1,1, 12, 0)),
    Message(message: "かきく", isMe: false, sentTime: DateTime(2021, 1,1, 12, 1)),
    Message(message: "かきfさfさflさgjsかgkんさlgんsなsんgkんかslgんく", isMe: false, sentTime: DateTime(2021, 1,1, 12, 1)),
    Message(message: "あいう", isMe: true, sentTime: DateTime(2021, 1,1, 12, 0)),
    Message(message: "かきく", isMe: false, sentTime: DateTime(2021, 1,1, 12, 1)),
    Message(message: "かきfさfさflさgjsかgkんさlgんsなsんgkんかslgんく", isMe: false, sentTime: DateTime(2021, 1,1, 12, 1)),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        //widgetを使用する理由
        //本来_TalkRoomPageStateとTalkRoomPageは別クラスなのでfinal String title;は _TalkRoomPageStateでは使えない
        //StatefulWidgetの中で定義した変数を使用したい
        //widget.titleでTalkRoomPageの中のtitleを使用できる
        title: Text(widget.name),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children : [
          Padding(
            padding: const EdgeInsets.only(bottom: 60),//スクロールした時に入力欄が隠れないようにする　height: 60は入力欄の高さ(containerの高さ)
            child: ListView.builder(
                physics: const RangeMaintainingScrollPhysics(), // トーク量が多くなった時にスクロールできるようにする
                shrinkWrap: true, //トークが少ないときにスクロールバーが出てしまうのを防ぐ
                reverse: true, // 一番下にスクロールした状態で表示
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0, bottom: index == 0 ? 10 : 0),
                    child: Row(
                      textDirection: messageList[index].isMe
                          ? TextDirection.rtl //TextDirection.rtlとは右から左に表示するという意味
                          : TextDirection.ltr, //TextDirection.ltrとは左から右に表示するという意味
                      children: [
                        Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.6, // 画面の70%まで表示 文字が多い時には改行する
                            ),
                            decoration: BoxDecoration(
                              color: messageList[index].isMe
                                  ? Colors.blue
                                  : Colors.green, //自分のメッセージなら青、相手のメッセージなら白
                              borderRadius: BorderRadius.circular(30),
                            ),
                            //margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            //color: messageList[index].isMe ? Colors.blue : Colors.green,BoxDecorationで色を指定をしないといけない
                            child: Text(messageList[index].message)
                        ),
                        Text(intl.DateFormat('HH:mm').format(messageList[index].sentTime)),
                      ],
                    ),
                  );
                }),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
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
