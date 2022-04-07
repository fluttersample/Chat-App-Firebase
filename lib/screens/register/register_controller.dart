
import 'dart:io';
import 'package:fiirebasee/core/app_notifier.dart';
import 'package:fiirebasee/managers/FCM.dart';
import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/managers/storage.dart';
import 'package:fiirebasee/models/user_detail_model.dart';
import 'package:fiirebasee/screens/home/home.dart';
import 'package:fiirebasee/screens/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class RegisterController extends BaseProvider
{
  final registerFormKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool isLoading = false;
  File? imageFile;

  void registerWithFirebase(BuildContext context)async
  {
    if (registerFormKey.currentState!
        .validate()) {

      updateValueLoading(true);
      String? url;
      if(imageFile!=null)
        {
         final task = await FirebaseManager.instance.uploadImage(imageFile);
          url = await task!.ref.getDownloadURL();

        }
        User? user = await FirebaseManager.instance
          .registerUsingEmailPassword(
          name: nameTextController.text,
          email: emailTextController.text,
          password: passwordTextController.text,
          context: context
      );

      final model = UserDetailModel(
          photoUrl: url,
          email: user?.email,
          displayName: user?.displayName,
        token: await FCM.instance.getTokenFCM()
      );
       final idDoc = await saveToFirestore(model);

      updateValueLoading(false);
      if (user != null) {
        Storage.saveDetailUser(nameTextController.text,
            emailTextController.text,
            true);
        Navigator.of(context)
            .pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                const HomeSc(),
          ),
        );
      }
    }
  }
  Future<String> saveToFirestore(UserDetailModel model) async{

    return await FirebaseManager.instance.saveUserToFirestore(model);
  }

  void selectImageFromGallery()async
  {

    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,

    );
    if (pickedFile != null) {
      _cropperImage(pickedFile.path);
    }
  }
  void _cropperImage(String path)async
  {

   imageFile = await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        cropStyle: CropStyle.circle,
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
   notifyListeners();
  }

  void updateValueLoading(bool value){
    isLoading=value;
    notifyListeners();
  }

  @override
  void disposeValues() {
    imageFile=null;
    isLoading=false;
  }



}
