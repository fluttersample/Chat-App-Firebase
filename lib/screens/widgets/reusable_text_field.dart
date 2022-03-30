import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {

  final TextInputType? textInputType;
  final String? hintText;
  final Widget? prefixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String? value)? functionValidate;
  final String? parametersValidate;
  final TextInputAction? actionKeyboard;

  const TextFormFieldWidget(
      {required this.hintText,
        required this.controller,
        required this.functionValidate,
        Key? key,
        this.focusNode,
        this.textInputType,
        this.defaultText,
        this.obscureText = false,
        this.parametersValidate,
        this.actionKeyboard = TextInputAction.next,
        this.prefixIcon}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const colorBlack = Colors.black;
    return Theme(
      data: theme,
      child: TextFormField(
        cursorColor: theme.primaryColor,
        obscureText: obscureText,
        keyboardType: textInputType,
        textInputAction: actionKeyboard,
        focusNode: focusNode,
        style: const TextStyle(
          color: colorBlack,
          fontSize: 16.0,
        ),
        initialValue: defaultText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,

          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
          contentPadding: const EdgeInsets.only(
              top: 12, bottom: 12, left: 8.0, right: 8.0),
          isDense: true,
          errorStyle: const TextStyle(
            color: Colors.red,

          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        controller: controller,
        validator: functionValidate,


      ),
    );
  }
}










