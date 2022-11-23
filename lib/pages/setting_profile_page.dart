

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingProfilePage extends StatefulWidget {
  const SettingProfilePage({Key? key}) : super(key: key);

  @override
  State<SettingProfilePage> createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  File? image;
  final ImagePicker _picker = ImagePicker();

  Future<void> selectImage() async {
    XFile? selected = await _picker.pickImage(source: ImageSource.gallery);
    if (selected == null) return;

    //setStateとは、画面を再描画するという意味
    setState(() {
      image = File(selected.path);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingProfilePage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
            children: const [
              SizedBox(width: 150 ,child: Text('Name')),
              Expanded(child: TextField()),//ExpandedでTextFieldを横幅いっぱいにする
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const SizedBox(width: 150 ,child: Text('Profile Image')),
              //ExpandedでContainerを横幅いっぱいにする
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () {
                        selectImage();
                  },
                      child: const Text('画像を選択')
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
            image == null
                ? const SizedBox()
                : SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.file(image!, fit: BoxFit.cover),
                  ),
            const SizedBox(height: 50,),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('編集')
              ),
            )
        ],
    ),
      ),
    );
  }
}
