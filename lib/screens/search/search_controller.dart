


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiirebasee/core/app_notifier.dart';
import 'package:fiirebasee/core/utils/utils.dart';
import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/managers/storage.dart';
import 'package:fiirebasee/models/chatRoom_model.dart';
import 'package:fiirebasee/models/user_detail_model.dart';
import 'package:fiirebasee/screens/conversation/conversation.dart';
import 'package:flutter/material.dart';

class SearchController extends BaseProvider{

  final controllerSearch = TextEditingController();

  Future<QuerySnapshot<Map<String,dynamic>>> getUsers()async{

    final result=  await FirebaseManager.instance.searchUserByName
      (name: controllerSearch.text);
    return result;
  }


  void createChatRoomAndNavigate({
    required UserDetailModel detailModel,
    required BuildContext context})
  {
    final String myName =Storage.readString(Storage.keyUsername);
    if(detailModel.displayName != myName)
      {
        String chatRoomId = getChatRoomId(detailModel.displayName!,myName);
        List<String> users = [
          detailModel.displayName!, myName];


        final model = ChatRoomModel(
            chatRoomId: chatRoomId,
            lastMessageSend: Utils.getCurrentDateTime(),
            users: users,
            urlImage: detailModel.photoUrl!);
        FirebaseManager.instance.createChatRoom(chatRoomId, model.toMap());
        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
           ConversationSc(
              chatRoomId: chatRoomId),));
      }else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You cannot send message to yourself !'))
      );
    }


  }

  getChatRoomId(String a , String b )
  {
    if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0))
      {
        return '$b\_$a';
      }else {
      return '$a\_$b';

    }
  }
  @override
  void disposeValues() {
  }
}