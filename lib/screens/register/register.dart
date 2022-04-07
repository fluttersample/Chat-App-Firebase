import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/screens/register/register_controller.dart';
import 'package:fiirebasee/screens/widgets/reusable_ele_button.dart';
import 'package:fiirebasee/screens/widgets/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/validator.dart';
import '../widgets/reusable_appbar.dart';




class RegisterPage extends StatefulWidget {
   const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _focusName = FocusNode();

  final _focusEmail = FocusNode();

  final _focusPassword = FocusNode();

  late RegisterController controller;

  @override
  void dispose() {
    controller.disposeValues();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    controller = Provider.of<RegisterController>(context,
    listen: false);
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: const AppbarWidget(
          text: 'Register',
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets
                .symmetric(
              vertical: 12,
              horizontal: 15
            ),
            child: Column(
              children: [
                // Image.asset('assets/img_verify.png',
                //     height: 200),
                _buildImageUploader(),
                const SizedBox(height: 15,),
                _buildForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(){
    return  Form(
      key: controller.registerFormKey,
      child: Column(
        children: <Widget>[
          TextFormFieldWidget(
            controller: controller.nameTextController,
            focusNode: _focusName,
            hintText: 'Name',
            functionValidate: (String? value) =>
                Validator.instance.validateName(name: value,),
          ),
          const SizedBox(height: 16.0),
          TextFormFieldWidget(
            controller: controller.emailTextController,
            focusNode: _focusEmail,
            hintText: 'Email',
            functionValidate: (String? value) =>
                Validator.instance.validateEmail(
                  email: value,
                ),
          ),
          const SizedBox(height: 16.0),

          TextFormFieldWidget(
            controller: controller.passwordTextController,
            focusNode: _focusPassword,
            obscureText: true,
            functionValidate: (String? value) =>
                Validator.instance.validatePassword(
                  password: value,
                ), hintText: 'Password',
          ),
          const SizedBox(height: 32.0),
          Consumer<RegisterController>
            (builder: (context, value, child) {
            if(value.isLoading)
            {
              return const CircularProgressIndicator();
            }
            return ElevationButtonWidget(
              text: 'Sign up',
              onPress: () async{
                controller.registerWithFirebase(context);
              },

            );
          },)

        ],
      ),
    );
  }
  Widget _buildImageUploader()
  {
    return   Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.selectImageFromGallery();
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
            child: Consumer<RegisterController>(
              builder: (context, value, child) {
                if(value.imageFile!=null)
                  {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.file(value.imageFile!,
                      fit: BoxFit.cover,),
                    );
                  }
                return Icon(Icons.photo_camera_outlined,
                    color: Colors.grey.shade700,
                    size: 35);
              },

            ),
          ),
        ),
        Text('Select Image Profile',
        style: TextStyle(
          color: Colors.grey.shade700,
        ),),

      ],
    );
  }
}

