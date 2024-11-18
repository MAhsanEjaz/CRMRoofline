import 'package:flutter/material.dart';

import '../constants.dart';


AppBar mAppbar(String text, {List<Widget>? action}) {
  return AppBar(
    title: Text(
      text,
      style: const TextStyle(color: blackColor),
    ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    actions: action,
  );
}

Text titleText(String text,
    {double? fontSize, FontWeight? fontWeight, Color? color}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontSize ?? 18, fontWeight: fontWeight ?? FontWeight.bold),
  );
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
          child: CircularProgressIndicator(
        color: appColor,
      )),
    );
  }
}
