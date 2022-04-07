

import 'package:firebase_messaging/firebase_messaging.dart';

class FCM{

  FCM._();

 static FCM instance = FCM._();

  Future<String> getTokenFCM()async {
 final messaging = FirebaseMessaging.instance;
    final token = await messaging.getToken();
    if (token != null) {
      return token;
    } else {
      throw Exception('Cannot Get Token');
    }
  }

  void listenToMessage()
  {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }
  Future<void> messageHandler(RemoteMessage message) async {
    print('background message ${message.notification!.body}');
  }

}