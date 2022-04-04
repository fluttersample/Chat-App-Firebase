
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/models/user_detail_model.dart';
import 'package:fiirebasee/screens/search/item_list.dart';
import 'package:fiirebasee/screens/search/search_controller.dart';
import 'package:fiirebasee/screens/widgets/reusable_appbar.dart';
import 'package:fiirebasee/screens/widgets/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchSc extends StatefulWidget {
  const SearchSc({Key? key}) : super(key: key);

  @override
  State<SearchSc> createState() => _SearchScState();
}

class _SearchScState extends State<SearchSc> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SearchController>
      (context,listen: false);
    QuerySnapshot<Map<String,dynamic>>? searchSnapshot;

    initiateSearch(){
      FirebaseManager.instance.
      searchUserByName(name: controller.controllerSearch.text)
          .then((value) {
            searchSnapshot=value;
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade300 ,
      appBar: const AppbarWidget(text: 'Search'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0)
                +const EdgeInsets.only(top: 15),
            child: TextFormFieldWidget(
                hintText: 'Search',
                controller: controller.controllerSearch,
              filled: true,
              fillColor: Colors.white,
              noneEnableBorder: true,
              suffixIcon: const Icon(
                  Icons.search,
                size: 20,
              ),
              actionKeyboard: TextInputAction.search,
              funOnSubmitted: (value){
                controller.getUsers();
                setState(() {

                });
                return null;
              },
            ),

          ),
          Expanded(child:
           searchList( controller))

        ],
      ),
    );
  }

  Widget searchList(SearchController searchController){
    return FutureBuilder<QuerySnapshot<Map<String,dynamic>>>(
      future: FirebaseManager.instance.searchUserByName(name:
     searchController.controllerSearch.text ),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>
         snapshot) {
        if(snapshot.connectionState ==ConnectionState.waiting)
          {
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasData )
          {
            print(snapshot.data?.docs.length);
            if(snapshot.data!.docs.isEmpty)
              {
                return const Center(
                  child: Text('Not Found Data'),
                );
              }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15
              ),
              itemExtent: 90,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final snap = snapshot.data?.docs[index];

                  final  data = UserDetailModel.fromMap(snap!.data());
                  return SearchTile(model: data,);

              } ,);

          }
        if(snapshot.hasError)
          {
            return Center(
              child: Text('Wrong '),
            );
          }
        return Center(child: const CircularProgressIndicator());

      }
    );
  }
}
