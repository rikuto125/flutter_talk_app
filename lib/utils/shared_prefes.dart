import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  // SharedPreferencesとは、アプリ内でデータを保存するための仕組み
  static SharedPreferences? _preferences;

  // SharedPreferencesのインスタンスを取得する
  Future<void> setPrefsInstance() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  //端末にuidを保存する
  static Future<void> setUid(String uid) async {
    await _preferences!.setString('uid', uid);
  }

  //端末に保存されているuidを取得
  static String? fetchUid() {
    print("uidを表示");
    print(_preferences!.getString('uid'));
    return _preferences!.getString('uid');
  }
}