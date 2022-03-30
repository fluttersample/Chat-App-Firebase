
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget {
  final String text;
  const AppbarWidget({Key? key,
  required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),

    );
  }
}
