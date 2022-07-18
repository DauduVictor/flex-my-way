import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexeryController extends GetxController {

  /// Instantiating a class of future values
  // var futureValues = FutureValues();

  /// Variable to hold the bool state of spinner
  final showSpinner = false.obs;

  /*Controllers and Variables for host a flex*/
  /// A [TextEditingController] to control the input text for name flex
  final TextEditingController hashTagController = TextEditingController();

  /// A [TextEditingController] to control the input text for select a date
  final TextEditingController locationController = TextEditingController();

  final noOfImageUpload = 0.obs;

  File? image;

  RxList<File> images = <File>[].obs;
}