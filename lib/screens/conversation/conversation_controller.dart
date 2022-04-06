

import 'package:fiirebasee/core/app_notifier.dart';
import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/managers/storage.dart';
import 'package:fiirebasee/models/message_model.dart';
import 'package:flutter/material.dart';

class ConversationController extends BaseProvider
{
  final TextEditingController textController =
  TextEditingController();
  void sendMessage(String chatRoomId, ){
    if(textController.text.isNotEmpty)
      {
        final myName = Storage.readString
          (Storage.keyUsername);
        final model = MessageModel(
            message: textController.text,
            sendBy: myName,
        time: DateTime.now().millisecondsSinceEpoch
            .toString());
        FirebaseManager.instance
            .addConversationMessage(chatRoomId,
            model.toMap());
        textController.clear();
      }


  }

  @override
  void disposeValues() {
    // TODO: implement disposeValues
  }
}