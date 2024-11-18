import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class CustomTextField extends StatefulWidget {
  String? hint;
  IconData? prefixIcon;
  IconData? suffix;
  Color? prefixColor;
  bool? obscureText;
  TextEditingController? controller;
  Function(String)? onChanged;
  String? Function(String?)? onValidate;
  Function()? suffixOnTap;
  TextInputType? inputType;
  int? maxLines;
  bool? isEnabled;

  CustomTextField(
      {super.key,
      this.hint,
      this.prefixIcon,
      this.suffix,
      this.onChanged,
      this.controller,
      this.suffixOnTap,
      this.maxLines,
      this.isEnabled,
      this.prefixColor,
      this.onValidate,
      this.inputType = TextInputType.text,
      this.obscureText = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  initState() {
    super.initState();
    widget.maxLines ?? 1;
    // widget.isEnabled ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)),
        child: TextFormField(
          enabled: widget.isEnabled,
          keyboardType: widget.inputType,
          maxLines: widget.maxLines,
          minLines: widget.maxLines,
          onChanged: (widget.onChanged),
          controller: widget.controller,
          obscureText: widget.obscureText!,
          validator: widget.onValidate,

          decoration: InputDecoration(
              suffixIconColor:
                  widget.controller!.text.isEmpty || widget.controller == null
                      ? blackColor
                      : appColor,
              prefixIconColor:
                  widget.controller!.text.isEmpty ? blackColor : appColor,
              suffixIcon: widget.suffix == null
                  ? null
                  : InkWell(
                      onTap: (widget.suffixOnTap), child: Icon(widget.suffix)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff00bb6c))),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: widget.prefixIcon == null || widget.suffix == null
                      ? 17
                      : 17),
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Icon(
                      widget.prefixIcon,
                      color: widget.prefixColor,
                    ),
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: const TextStyle(fontWeight: FontWeight.w400)
              // contentPadding: const EdgeInsets.symmetric(horizontal: 10)
              ),
        ),
      ),
    );
  }
}
