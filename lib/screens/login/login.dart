import 'package:avatar_glow/avatar_glow.dart';
import 'package:fiirebasee/managers/FCM.dart';
import 'package:fiirebasee/managers/firebase_manager.dart';
import 'package:fiirebasee/managers/validator.dart';
import 'package:fiirebasee/models/user_detail_model.dart';
import 'package:fiirebasee/screens/login/login_controller.dart';
import 'package:fiirebasee/screens/register/register.dart';
import 'package:fiirebasee/screens/widgets/reusable_appbar.dart';
import 'package:fiirebasee/screens/widgets/reusable_ele_button.dart';
import 'package:fiirebasee/screens/widgets/reusable_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class LoginSc extends StatefulWidget {
  const LoginSc({Key? key}) : super(key: key);

  @override
  State<LoginSc> createState() => _LoginScState();
}



class _LoginScState extends State<LoginSc> {

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  late LoginController controller;
  @override
  void initState() {
    controller = Provider.of<LoginController>(context,listen: false);

    super.initState();
  }

@override
  void dispose() {
        super.dispose();
        controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar:const AppbarWidget(
            text: 'Firebase Authentication',
          ),

        body: _buildContent()
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(),
            _buildAuthWidget(),
            _buildRegister()],
        ),
      ),
    );
  }

  Widget _buildAuthWidget() {
    return Column(
      children: [
        const Text(
          'Login',
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        const SizedBox(
          height: 8,
        ),
        Form(
          key: controller.formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                    hintText: 'Email',
                  functionValidate: (String? value) =>
                      Validator.instance.validateEmail(email: value),
                  controller: controller.emailTextController,
                  focusNode: _focusEmail,
                ),
                const SizedBox(height: 12.0),
                TextFormFieldWidget(
                  hintText: 'Password',
                  obscureText: true,
                  functionValidate: (String? value) =>
                      Validator.instance.validatePassword(password:  value),
                  controller: controller.passwordTextController,
                  focusNode: _focusPassword,
                ),

              ],
            )),
        const SizedBox(
          height: 15,
        ),
      Consumer<LoginController>(
          builder: (context, value, child) {
            if(value.isLoading)
              {
                return const CircularProgressIndicator();
              }
            return   ElevationButtonWidget(
                onPress: () async{
                controller.signInFromFirebase(context);
                   },
                  text: 'Sign In');
          },),


      ],
    );
  }

   _buildGoogleSignIn(){
    return [
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          const Expanded(child: Divider(
          )),
          Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 12
              ),
              child: const Text('OR',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),)),
          const Expanded(child: Divider()),

        ],
      ),
      const SizedBox(
        height: 20,
      ),
      GestureDetector(
        onTap: () {
          controller.signInFromGoogle();
        },
        child: Container(
          height: 50,
          width: 50,
          padding: EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0,0),
                spreadRadius: 2,
                blurRadius: 1,
              ),
            ],

          ),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: Image.asset(
              'assets/ic_google.png',
              height: 40,
            ),
            radius: 25.0,
          ),
        ),
      ),
    ];
  }

  /// not A member ? register now
  Widget _buildRegister() {
    return Column(
      children: [
        ..._buildGoogleSignIn(),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: RichText(
            text: TextSpan(
                style: const TextStyle(color: Colors.black45),
                text: 'Not A Member ? ',
                children: [
                  TextSpan(
                      text: 'Register Now',
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ));

                        })
                ]),
          ),
        ),
      ],
    );
  }
}
