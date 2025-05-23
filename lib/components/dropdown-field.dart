import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flutter/material.dart';


/// This class holds the dropdown button styles and code
class CustomDropdownButtonField extends StatelessWidget {

  const CustomDropdownButtonField({
    Key? key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator
  }) : super(key: key);

  final String hintText;
  final List<dynamic> items;
  final Function(Object?)? onChanged;
  final String? value;
  final String? Function(Object?)? validator;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        DropdownButtonFormField(
          onChanged: onChanged,
          isExpanded: true,
          validator: validator,
          value: value,
          items: items.map((value) => DropdownMenuItem(
            value: value,
            child: Text(
              '$value',
              style: textTheme.bodyText2,
            ),
          ),
          ).toList(),
          // hint: FittedBox(
          //   child: Text(
          //     hintText,
          //     style: textTheme.bodyText2,
          //   ),
          // ),
          icon: const Icon(Icons.expand_more),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(24, 24, 12, 16),
            focusColor: neutralColor,
            labelText: hintText,
            labelStyle:textTheme.bodyText2,
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
        const SizedBox(height: 24),
      ],
    );
  }
}
