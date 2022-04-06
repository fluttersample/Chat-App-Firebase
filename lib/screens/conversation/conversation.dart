import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/managers/storage.dart';
import 'package:fiirebasee/models/message_model.dart';
import 'package:fiirebasee/screens/conversation/conversation_controller.dart';
import 'package:fiirebasee/screens/widgets/reusable_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationSc extends StatefulWidget {
  final String? chatRoomId;

  const ConversationSc({Key? key, this.chatRoomId}) : super(key: key);

  @override
  State<ConversationSc> createState() => _ConversationScState();
}

class _ConversationScState extends State<ConversationSc> {
  late ConversationController controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<ConversationController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: const AppbarWidget(
        text: 'ChatRoom',
      ),
      body: Stack(
        children: [
          _chatMessageList(),
          _buildBottomTextField(controller)
        ],
      ),
    );
  }

  Widget _buildBottomTextField(ConversationController controller) {
    return Positioned(
      bottom: 12,
      right: 15,
      left: 15,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.textController,
                decoration: InputDecoration(
                    hintText: 'Type a message',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    contentPadding: const EdgeInsets.only(left: 15, top: 15),
                    fillColor: Colors.white),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Ink(
              decoration: const ShapeDecoration(
                  shape: CircleBorder(), color: Colors.white),
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    textDirection: TextDirection.rtl),
                iconSize: 30,
                color: Colors.blue,
                splashRadius: 24,
                onPressed: () {
                  controller.sendMessage(widget.chatRoomId!);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _chatMessageList() {
    return StreamBuilder
    <QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseManager.instance
          .getConversationMessage(widget.chatRoomId!),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
      snapshot) {
        if(snapshot.hasData)
          {
            if(snapshot.data!.docs.isEmpty)
            {
              return const Center(
                child: Text('Not Found Data'),
              );
            }
            return Container(
              margin: const EdgeInsets.only(bottom: 65),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 25,
                bottom: 15),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index];
                  final model = MessageModel.fromMap(
                      data.data());

                  return MessageTile(message: model,
                    isSendByMe: model.sendBy
                    == Storage.readString(
                            Storage.keyUsername),
                  );
                },
              ),
            );
          }
        return const Center(child: CircularProgressIndicator());

      },
    );
  }

}

class MessageTile extends StatelessWidget {
  final MessageModel message;
  final bool isSendByMe ;
  const MessageTile({Key? key,
  required this.message,
  required this.isSendByMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight
      : Alignment.centerLeft,
      child: Container(
        margin : const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius
              .only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isSendByMe?15:0),
            bottomRight: Radius.circular(isSendByMe?0:15)
          ),
          gradient: LinearGradient(
            colors:
            isSendByMe ? [
              Colors.lightBlueAccent,
              Colors.blue,

            ]:
            [
              Colors.grey,
              Colors.grey.shade400,
            ]
          )

        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(message.message
          ,style: const TextStyle(
              color: Colors.white,
              fontSize: 17
            ),),
        ),
      ),
    );
  }
}

