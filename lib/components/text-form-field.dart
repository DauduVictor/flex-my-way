import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.name,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.suffix,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.bottomSpacing = true,
    this.maxLength,
  }) : super(key: key);

  final String? hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final TextInputAction? textInputAction;
  final TextEditingController textEditingController;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final Widget? suffix;
  final bool readOnly;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autoValidateMode;
  final bool? bottomSpacing;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        TextFormField(
          controller: textEditingController,
          onChanged: onChanged,
          validator: validator,
          obscureText: obscureText,
          maxLines: maxLines,
          cursorColor: neutralColor,
          autovalidateMode: autoValidateMode,
          readOnly: readOnly,
          maxLength: maxLength,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          keyboardType: keyboardType,
          style: textTheme.bodyMedium!.copyWith(
            fontSize: 14.5,
          ),
          autocorrect: false,
          onTap: onTap,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            suffixIcon: suffix,
            // hintText: hintText,
            hintStyle: textTheme.bodyMedium,
            labelText: hintText,
            focusColor: neutralColor,
            contentPadding: const EdgeInsets.fromLTRB(24, 24, 12, 16),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              borderSide: BorderSide(color: neutralColor),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              borderSide: BorderSide(color: neutralColor),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              borderSide: BorderSide(color: neutralColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              borderSide: BorderSide(color: neutralColor),
            ),
          ),
        ),
        bottomSpacing == true ? const SizedBox(height: 24) : const SizedBox(),
      ],
    );
  }
}
