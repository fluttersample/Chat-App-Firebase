

import 'package:shared_preferences/shared_preferences.dart';

class Storage{

  static String keyIsLogin='IsLoginKey';
  static String keyUsername='UsernameKey';
  static String keyUserEmail='UserEmailKey';

  static SharedPreferences? prefs;
  static init()async
  {
    prefs ??= await SharedPreferences.getInstance();
  }


  static writeString(String key,String value) =>  prefs?.setString(key, value);

  static writeBool(String key,bool value) =>  prefs?.setBool(key, value);

  static writeInt(String key,int value) =>prefs?.setInt(key, value);

  static  readBool(String key) =>  prefs!.getBool(key);

  static readString(String key) =>  prefs!.getString(key);

  static readInt(String key) =>  prefs!.getInt(key);

  static deleteValue(String key)  =>  prefs?.remove( key);

  static deleteAll() =>  prefs!.clear();

  static saveDetailUser(String name, String email , bool isLogin){
    writeString(keyUsername, name);
    writeString(keyUserEmail, email);
    writeBool(keyIsLogin, isLogin);

  }




}