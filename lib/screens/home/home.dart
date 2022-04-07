

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiirebasee/managers/FCM.dart';
import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/managers/storage.dart';
import 'package:fiirebasee/models/chatRoom_model.dart';
import 'package:fiirebasee/models/user_detail_model.dart';
import 'package:fiirebasee/screens/conversation/conversation.dart';
import 'package:fiirebasee/screens/home/home_controller.dart';
import 'package:fiirebasee/screens/search/search.dart';
import 'package:fiirebasee/screens/widgets/reusable_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeSc extends StatefulWidget {
  const HomeSc({Key? key}) : super(key: key);

  @override
  State<HomeSc> createState() => _HomeScState();
}

class _HomeScState extends State<HomeSc> {
  @override
  void initState() {
    super.initState();
    print(Storage.readString(Storage.keyUsername));
    FCM.instance.listenToMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
     appBar: const AppbarWidget(text: 'Home'),
      body: _buildChatRoomList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
            const SearchSc(),));
        },
        child: const Icon(Icons.search),
      ),
    );
  }



  Widget _buildChatRoomList()
  {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseManager.instance.getChatRooms(
          Storage.readString(Storage.keyUsername)),
      builder:(context, snapshot) {
        if(snapshot.hasData)
          {
            if(snapshot.data!.docs.isEmpty)
            {
              return const Center(
                child: Text('Not Found Data'),
              );
            }
            return ListView.builder(
              itemExtent: 75,
              padding: const EdgeInsets.symmetric(
                  vertical: 18,
                horizontal: 12
             ),
              itemCount: snapshot.data!.docs.length,
                itemBuilder:(context, index) {
                  final data = snapshot.data!.docs[index];
                  print(data.data());
                  final model = ChatRoomModel
                      .fromMap(data.data());
                  return ItemChatRoomTile(model: model,);
                }, );
          }
        return const Center(child: CircularProgressIndicator());
      },
       );
  }

}
class ItemChatRoomTile extends StatelessWidget {
  final ChatRoomModel model;
  const ItemChatRoomTile({Key? key,
  required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder:
      (context) =>  ConversationSc(
        chatRoomId: model.chatRoomId,
      ),)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(model.urlImage,
                width: 50,
                height: 50,),
              )
            ),
            const SizedBox(width: 8,),
            Text(model.chatRoomId
                .replaceAll('_', '')
              .replaceAll(
                Storage.readString(Storage.keyUsername),
                ''),
            style: const TextStyle(
              fontSize: 20,
            ),),
            const Spacer(),

            Text(model.lastMessageSend,
            style: const TextStyle(
              color: Colors.grey
            )),
            const SizedBox(
              width: 15,
            )

          ],
        ),
      ),
    );
  }
}

