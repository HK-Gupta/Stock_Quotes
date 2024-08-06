import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final bool? autoCorrect, inputFilled, obscureText, inputSuggestions, readOnly;
  final InputBorder? border,
      focusedBorder,
      enabledBorder,
      errorBorder,
      disableBorder;
  final int? maxLines, minLines, maxLength;
  final Color? inputFillColor;
  final Widget? prefixIcon, suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final TextInputType? inputKeyboardType;
  final TextInputAction? inputAction;
  final TextStyle? inputLabelStyle, inputHintStyle, inputTextStyle;
  final String? inputLabel, inputHint, initialValue;
  final TextCapitalization? inputCapitalisation;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;


  const MyFormField({super.key, this.autoCorrect, this.inputFilled, this.obscureText, this.inputSuggestions, this.readOnly, this.border, this.focusedBorder, this.enabledBorder, this.errorBorder, this.disableBorder, this.maxLines, this.minLines, this.maxLength, this.inputFillColor, this.prefixIcon, this.suffixIcon, this.contentPadding, this.controller, this.inputKeyboardType, this.inputAction, this.inputLabelStyle, this.inputHintStyle, this.inputTextStyle, this.inputLabel, this.inputHint, this.initialValue, this.inputCapitalisation, this.validator, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      autocorrect: autoCorrect ?? false,
      obscureText: obscureText ?? false,
      enableSuggestions: inputSuggestions ?? false,
      keyboardType: inputKeyboardType,
      textInputAction: inputAction,
      textCapitalization: inputCapitalisation?? TextCapitalization.none,
      style: inputTextStyle,
      decoration: InputDecoration(
        labelText: inputLabel,
        labelStyle: inputLabelStyle,
        hintText: inputHint,
        hintStyle: inputHintStyle,
        filled: inputFilled,
        fillColor: inputFillColor,
        border: border,
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        errorBorder: errorBorder,
        disabledBorder: disableBorder,
        contentPadding: contentPadding,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),

    );
  }
}