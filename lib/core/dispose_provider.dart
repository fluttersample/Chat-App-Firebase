
import 'package:fiirebasee/screens/login/login_controller.dart';
import 'package:fiirebasee/screens/profile/profile_controller.dart';
import 'package:fiirebasee/screens/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:fiirebasee/core/app_notifier.dart';
import 'package:provider/provider.dart';

class AppProviders {
  static List<BaseProvider> getDisposableProviders(BuildContext context) {
    return [
      Provider.of<RegisterController>(context, listen: false),
      Provider.of<LoginController>(context, listen: false),
      Provider.of<ProfileController>(context, listen: false),

      //...other disposable providers
    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }
}