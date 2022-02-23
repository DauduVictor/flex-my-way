import 'package:flex_my_way/src/content/constants/constants.dart';
import 'package:flex_my_way/src/shared/widgets/spacing.dart';
import 'package:flutter/material.dart';

class CustomDropdownButtonField extends StatelessWidget {
  const CustomDropdownButtonField({
    Key? key,
    required this.hintText,
    required this.items,
    required this.onChanged,
  }) : super(key: key);
  final String hintText;
  final List<dynamic> items;
  final Function(Object?)? onChanged;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: DropdownButtonFormField(
            onChanged: onChanged,
            isExpanded: true,
            items: items
                .map((val) => DropdownMenuItem(value: val, child: Text('$val')))
                .toList(),
            hint: FittedBox(
                child: Text(
              hintText,
              style: textTheme.bodyText2,
            )),
            icon: const Icon(Icons.expand_more),
            decoration: const InputDecoration(
              focusColor: AppColors.darkTextColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: AppColors.darkTextColor),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: AppColors.darkTextColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: AppColors.darkTextColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: AppColors.darkTextColor),
              ),
            ),
          ),
        ),
        const Spacing.bigHeight(),
      ],
    );
  }
}
