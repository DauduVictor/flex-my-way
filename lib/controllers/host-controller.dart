import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../util/constants/constants.dart';

class HostController extends GetxController {

  /// Variable to hold the bool state of spinner
  final showSpinner = false.obs;

  /// Bool variable to hold use database
  final useDatabase = yesOrNo[1].obs;

  final isUploaded = false.obs;

  /// A [TextEditingController] to control the input text for current password
  final TextEditingController noOfPeople = TextEditingController();
}