
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSize{
  final String text;
  const AppbarWidget({Key? key,
  required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
