
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendStorage extends StatefulWidget {
  const SendStorage({Key? key}) : super(key: key);

  @override
  State<SendStorage> createState() => _SendStorageState();
}

class _SendStorageState extends State<SendStorage> {
  var storage = FirebaseStorage.instance;
  File? imagePik;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildImageUploader(),
    );
  }


  Widget _buildImageUploader()
  {
    return   Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              selectImageFromGallery();
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0,0),
                    spreadRadius: 2,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child:  imagePik ==null?
                Image.asset('assets/img_verify.png') :
                Image.file(imagePik!,
                  fit: BoxFit.cover,),
              )
            ),
          ),
          Text('Select Image Profile',
            style: TextStyle(
              color: Colors.grey.shade700,
            ),),
          SizedBox(height: 50,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size( double.infinity, 80,)
            ),
              onPressed: (){
                uploadImage();
    },
              child: Text("Send",
              style: TextStyle(
                fontSize: 35
              ),))

        ],
      ),
    );
  }

  void selectImageFromGallery()async
  {

    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,

    );
    if (pickedFile != null) {
      imagePik=File(pickedFile.path);
      setState(() {

      });
    }
  }

  Future uploadImage()async{
    if(imagePik==null) return ;

    String basename = p.basename(imagePik!.path);
    TaskSnapshot snapshot = await storage
        .ref()
        .child("assets/$basename")
        .putFile(imagePik!);

    if (snapshot.state == TaskState.success) {
      final String downloadUrl =
      await  snapshot.ref.getDownloadURL();
    print(downloadUrl);


      const snackBar = SnackBar(content: Text('Yay! Success'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print(
          'Error from image repo ${snapshot.state.toString()}');
      throw ('This file is not an image');
    }









    //    final _firebaseStorage = FirebaseStorage.instance;
    // //   final fileName = path.basename(file.path);
    //
    //
    //    final destination = 'images2/$fileName';
    //
    //    final snapshot=  _firebaseStorage.ref()
    //        .child(destination);
    //    final uploadTask = snapshot.putFile(file);
    //    await uploadTask.whenComplete(() {
    //      print("OMMMPLATE");
    //    });
    //
    //    // final downloadUrl = await snapshot.ref.getDownloadURL();
    //    // print(downloadUrl);


  }
}
