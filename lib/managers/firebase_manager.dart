

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiirebasee/models/user_detail_model.dart';
import 'package:fiirebasee/screens/widgets/utils.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
class FirebaseManager{
  FirebaseManager._();

  static  FirebaseManager instance = FirebaseManager._();
  static  FirebaseStorage? storage ;
  static  FirebaseAuth? auth ;
  static  FirebaseFirestore? fireStore;
  static User? user;

  // static FireBaseInitial instance1 (){
  //   if(instance == null )
  //     {
  //       instance = FireBaseInitial._();
  //     }
  //   return instance;
  // }


  Future<FirebaseApp> initialFirebase()async{
    FirebaseApp firebaseApp = await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDkgLjzRhtss8XW1onh2b70p9jwes3CeVE',
            appId:'1:610218298254:android:c7e179b550c2b78244f2df',
            messagingSenderId: '610218298254',
            projectId: 'test-firebase-c04ad')
    );
    storage = FirebaseStorage.instance;
    auth =FirebaseAuth.instance;
    fireStore =FirebaseFirestore.instance;

    return firebaseApp;
  }

  Future<User?> registerUsingEmailPassword({
  required String name,
    required String email,
    required String password,
    required BuildContext context
     }) async{

    try {
      final userCredential = await auth
          !.createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user!.reload();
      user = auth!.currentUser;


    }on FirebaseAuthException catch (e)
    {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Util.showSnackBar('The password provided is too weak',
            context: context);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Util.showSnackBar('The account already exists for that email',
            context: context);
      }
    } catch(e) {
       print(e);
    }
    return user;

  }


  Future<User?> signInUsingEmailPassword({
  required String email,
    required String password,
    required BuildContext context
     }) async{

    User? user;
    try{

      final userCredential = await auth!.signInWithEmailAndPassword
        (email: email, password: password);
      user = userCredential.user;

    }on FirebaseAuthException catch(e)
    {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Util.showSnackBar(
          'No user found for that email',
          context: context, );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        Util.showSnackBar(
          'Wrong password provided',
          context: context, );
      }
    }
    return user;
    }

    Future<void> singOutUser()async
    {
      return auth!.signOut();
    }


   Future<User?> refreshUser(User user) async {

    await user.reload();
    User? refreshedUser = auth!.currentUser;
    return refreshedUser;
  }


  Future<TaskSnapshot?> uploadImage(File? file)async{
    if(file ==null) return Future.value(null) ;
      print(file.path);
      final fileName = path.basename(file.path);
     TaskSnapshot snapshot = await storage
        !.ref()
        .child("assets/$fileName")
        .putFile(file);
    if (snapshot.state == TaskState.success) {
    //  final String downloadUrl = await snapshot.ref.getDownloadURL();
      print('Success');
    } else {
      print('Error from image repo ${snapshot.state.toString()}');
      throw ('This file is not an image');
    }

    return Future.value(snapshot);

  }




  Future<String> saveUserToFirestore(UserDetailModel model)async{
  final idDuc=  await  fireStore!.collection('users').add(model.toMap());
  return idDuc.id;

  }

  Future<String?> getDucId({required String email })async{
    final id = await fireStore!.collection('users')
        .where('email' , isEqualTo: email).get();
    return id.docs[0].id;
  }

  Future<QuerySnapshot<Map<String,dynamic>>> searchUserByName({required String name})
  async {
   return  await fireStore!.collection('users')
      .where('displayName',isEqualTo: name).get();


  }


  // Future<FirebaseAppCheck> appCheck()async
  // {
  //   FirebaseAppCheck firebaseAppCheck =  FirebaseAppCheck.instance;
  //   await firebaseAppCheck.activate();
  //   await firebaseAppCheck.setTokenAutoRefreshEnabled(true);
  //   final z = firebaseAppCheck.app.options.projectId;
  //   print(z);
  //   return firebaseAppCheck;
  // }
}

