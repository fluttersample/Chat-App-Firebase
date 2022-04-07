
import 'package:fiirebasee/core/app_notifier.dart';
import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/managers/storage.dart';
import 'package:fiirebasee/models/user_detail_model.dart';
import 'package:fiirebasee/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends BaseProvider{
  final formKey = GlobalKey<FormState>();
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  bool isLoading = false;

  final emailTextController = TextEditingController(
    text: 'test@gmail.com'
  );
  final passwordTextController = TextEditingController(
    text: 'test123'
  );

  void signInFromGoogle()async{
    googleSignInAccount = await googleSignIn.signIn();
    if(googleSignInAccount!=null)
    {
      final data = UserDetailModel(
          displayName: googleSignInAccount!.displayName,
          email: googleSignInAccount!.email,
          photoUrl: googleSignInAccount!.photoUrl
      );
      print(data.email);
    }
  }

  void signInFromFirebase(BuildContext context)async
  {
    if (formKey.currentState!.validate()) {
      updateValueLoading(true);
      User? user =
      await FirebaseManager.instance.signInUsingEmailPassword(
          email: emailTextController.text,
          password: passwordTextController.text,
          context: context
      );
      updateValueLoading(false);

      final id =await FirebaseManager.instance
          .getDucId(email: emailTextController.text);

      if (user != null) {

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //       builder: (context) => Profile(
        //         idDuc: id,
        //       )),
        // );
        Storage.deleteAll();
        final name= await FirebaseManager.instance.getUserNameByEmail(
            email: emailTextController.text);
      Storage.saveDetailUser(name, emailTextController.text,
          true);
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => const HomeSc()),
        );



      }
    }
  }

  void updateValueLoading(bool value){
    isLoading=value;
    notifyListeners();
  }

  @override
  void disposeValues() {
  }

}