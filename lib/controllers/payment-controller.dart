import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flutter/material.dart';

class PaymentController extends GetxController {

  /// variable to know the current state of the payment options
  final paymentOption = 1.obs;

  /// variable to hold the bool state of generated account
  final isAccountGenerated = false.obs;

  /// variable to hold the bool state of generated account -api
  final isAccountGeneratedFromApi = false.obs;

  /*Controllers and Variables for card details*/
  /// A [TextEditingController] to control the input text for card name
  final TextEditingController nameCardController = TextEditingController();

  /// A [TextEditingController] to control the input text for card name
  final TextEditingController cardDigit = TextEditingController();

  /// A [TextEditingController] to control the input text for card name
  final TextEditingController expiryDate = TextEditingController();

  /// A [TextEditingController] to control the input text for card name
  final TextEditingController cvv = TextEditingController();


  void copyMessage(String text) async {
    Clipboard.setData(
        ClipboardData(
          text: text
        )).then((value) {
      Functions.showMessage('Account number copied!');
    }).catchError((e){
      Functions.showMessage('Could not copy');
    });
  }

}