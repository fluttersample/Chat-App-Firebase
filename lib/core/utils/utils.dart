

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils{


  static String getCurrentDateTime(){
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.jm().format(now);
    return formattedTime;
  }

  static showSnackBar (String message,
      {required BuildContext context ,
        Color bgColor = Colors.blue,
        String? actionMessage
      }){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          action: (actionMessage != null)
              ? SnackBarAction(
              textColor: Colors.white,
              label: actionMessage,
              onPressed: (){
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }
          )
              : null,
          duration: const Duration(seconds: 2),
          backgroundColor: bgColor,
        ));
  }

}