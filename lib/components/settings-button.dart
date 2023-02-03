import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../util/constants/constants.dart';

class ReusableSettingsButton extends StatelessWidget {

  final String name;
  final IconData icon;
  final void Function() onPressed;

  const ReusableSettingsButton({
    Key? key,
    required this.name,
    required this.icon,
    required this.onPressed
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.black,
            ),
            title: Text(
              name,
              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}