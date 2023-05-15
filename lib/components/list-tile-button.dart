import 'package:flutter/material.dart';
import '../util/constants/constants.dart';

class ListTileButton extends StatelessWidget {

  final void Function() onPressed;
  final String title;

  const ListTileButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.5,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 21,
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}