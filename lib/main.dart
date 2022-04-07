import 'package:fiirebasee/managers/FCM.dart';
import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/managers/storage.dart';
import 'package:fiirebasee/screens/conversation/conversation.dart';
import 'package:fiirebasee/screens/conversation/conversation_controller.dart';
import 'package:fiirebasee/screens/home/home.dart';
import 'package:fiirebasee/screens/home/home_controller.dart';
import 'package:fiirebasee/screens/login/login.dart';
import 'package:fiirebasee/screens/login/login_controller.dart';
import 'package:fiirebasee/screens/register/register.dart';
import 'package:fiirebasee/screens/register/register_controller.dart';
import 'package:fiirebasee/screens/search/search.dart';
import 'package:fiirebasee/screens/search/search_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseManager.instance.initialFirebase();
  await Storage.init();
  FirebaseMessaging.onBackgroundMessage(
      (message) => FCM.instance.messageHandler(message),
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        child: const LoginSc(),),
        ChangeNotifierProvider(create:(context) =>  RegisterController(),
        child: const RegisterPage(),),

        ChangeNotifierProvider(create:(context) =>  HomeController(),
        child: const HomeSc(),),

        ChangeNotifierProvider(create:(context) =>  SearchController(),
         child: const SearchSc(),),

       ChangeNotifierProvider(
         create:(context) =>  ConversationController(),
        child: const ConversationSc(),
       lazy: true),



      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginSc(),
      ),
    );
  }
}


