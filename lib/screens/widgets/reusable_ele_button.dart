import 'package:flutter/material.dart';




class ElevationButtonWidget extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;
  final String text;
  final VoidCallback onPress;
   const ElevationButtonWidget({
    required this.onPress,
    required this.text,
    Key? key,
    this.height = 36,
    this.width = 150,
    this.color ,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          primary: color,
          minimumSize: Size(width, height)
        ),
        child: Text(
          text,
          style: const TextStyle(
             fontSize: 16
          ),
        ));
  }
}
