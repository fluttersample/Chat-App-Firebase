
import 'package:fiirebasee/models/user_detail_model.dart';
import 'package:fiirebasee/screens/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTile extends StatelessWidget {
  final UserDetailModel model ;
  const SearchTile({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal:  12),
        child: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  model.photoUrl??'',
                  errorBuilder: (context, error, stackTrace) =>
                  Image.asset('assets/ic_google.png'),
                  loadingBuilder: (con,widget ,_) =>const
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(child: CircularProgressIndicator(

                    )),
                  ),
                ),
              )
            ),
            const SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130,
                  child: Text(model.displayName!,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 130,
                  child: Text(model.email!,
                    maxLines: 1,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            OutlinedButton.icon(
                onPressed: (){
                  context.read<SearchController>()
                      .createChatRoomAndNavigate(
                      detailModel:  model,
                      context: context);
                },
                label: const Icon(Icons.message_rounded,
                size: 20),
               icon:  Text('Message'),
                )
          ],
        ),
      ),
    );
  }
}
