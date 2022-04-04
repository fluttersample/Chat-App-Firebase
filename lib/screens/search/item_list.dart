
import 'package:fiirebasee/models/user_detail_model.dart';
import 'package:flutter/material.dart';

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
                  model.photoUrl!,
                  errorBuilder: (context, error, stackTrace) =>
                  Image.asset('assets/ic_google.png'),
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
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 130,
                  child: Text(model.email!,
                    maxLines: 1,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            OutlinedButton.icon(
                onPressed: (){},
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
