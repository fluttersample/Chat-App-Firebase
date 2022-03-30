import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/screens/SendStorage.dart';
import 'package:fiirebasee/screens/login/login.dart';
import 'package:fiirebasee/screens/login/login_controller.dart';
import 'package:fiirebasee/screens/register/register.dart';
import 'package:fiirebasee/screens/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseManager.instance.initialFirebase();
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
        child: const RegisterPage(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginSc(),
      ),
    );
  }
}


