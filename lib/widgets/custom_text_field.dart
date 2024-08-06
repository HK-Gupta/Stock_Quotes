import 'package:flutter/material.dart';
import 'package:stock_quote_app/widgets/my_form_filed.dart';

class CustomTextField extends StatelessWidget {
  final int? maxLines, minLines;
  final String? inputHint;
  final Widget? suffixIcon, prefixIcon;
  final bool? obscureText, readOnly;
  final TextInputType? inputKeyBoardType;
  final Color? inputFillColor;
  final InputBorder? border, focusedBorder, enabledBorder;
  final Function()? clickMe;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;

  const CustomTextField({super.key, this.maxLines, this.minLines, this.inputHint, this.suffixIcon, this.prefixIcon, this.obscureText, this.inputKeyBoardType, this.inputFillColor, this.border, this.focusedBorder, this.enabledBorder, this.clickMe, this.validator, this.controller, this.hintStyle, this.onChanged, this.readOnly});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyFormField(
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(15)
                ),
            maxLines: maxLines ?? 1,
            minLines: minLines ?? 1,
            controller: controller,
            validator: validator,
            readOnly: readOnly,
            inputFilled: true,
            inputFillColor: inputFillColor ?? Theme.of(context).colorScheme.primaryContainer,
            inputHint: inputHint,
            obscureText: obscureText,
            inputKeyboardType: inputKeyBoardType,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            border: border ?? OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary
                ),
                borderRadius: BorderRadius.circular(15)
            ),

            focusedBorder: focusedBorder?? OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: suffixIcon,
            ),
            onChanged: onChanged,
            prefixIcon: prefixIcon,
            inputTextStyle: Theme.of(context).textTheme.bodySmall,
            inputHintStyle: hintStyle ?? Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}