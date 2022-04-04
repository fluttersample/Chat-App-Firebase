


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiirebasee/core/app_notifier.dart';
import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:flutter/material.dart';

class SearchController extends BaseProvider{

  final controllerSearch = TextEditingController();

  Future<QuerySnapshot<Map<String,dynamic>>> getUsers()async{

    final result=  await FirebaseManager.instance.searchUserByName
      (name: controllerSearch.text);
    return result;
  }
  @override
  void disposeValues() {
  }
}