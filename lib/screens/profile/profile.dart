
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/models/user_detail_model.dart';
import 'package:fiirebasee/screens/widgets/reusable_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


class Profile extends StatefulWidget {

  final String? idDuc;
  const Profile({Key? key,required this.idDuc}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {



  Future<UserDetailModel?> getDataFromFirestore()async{

    final docUser= FirebaseManager.fireStore!.collection('users')
        .doc(widget.idDuc);
    final snapshot= await docUser.get();

    if(snapshot.exists)
      {
        return UserDetailModel.fromMap(snapshot.data()!);
      }
    return null;
  }




  @override
  void initState() {
    print("SAD++++++++++++  " + widget.idDuc!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const AppbarWidget(
        text: 'Profile User',
      ),
      body:  //Container()

      FutureBuilder<UserDetailModel?>(
        future:  getDataFromFirestore(),
        builder: (context,  snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if(snapshot.hasData)
            {
              final user = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    SizedBox(
                      height: 200,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          user.photoUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(user.displayName!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )),
                    const SizedBox(height: 10,),
                    Text(user.email!),
                  ],
                ),
              );
            }

          return const Center(
            child: CircularProgressIndicator(),
          );



        }
      ),
    );
  }
}
