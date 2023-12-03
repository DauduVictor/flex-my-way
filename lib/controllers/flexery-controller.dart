import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../networking/flex-datasource.dart';
import '../util/constants/functions.dart';
import 'package:flex_my_way/model/model.dart';

class FlexeryController extends GetxController {
  /// dynamic variable to hold an instance of flexDataSource
  var api = FlexDataSource();

  /// Variable to hold state of the search spinner
  final showSearchSpinner = false.obs;

  final flexeryFilter = 1.obs;

  /// Variable to hold the bool state of spinner
  final showSpinner = false.obs;

  /*Controllers and Variables for host a flex*/
  /// A [TextEditingController] to control the input text for name flex
  final TextEditingController hashTagController = TextEditingController();

  /// A [TextEditingController] to control the input text for select a date
  final TextEditingController locationController = TextEditingController();

  final noOfImageUpload = 0.obs;

  final isFlexeryImagesLoaded = false.obs;

  File? image;

  RxList<File> images = <File>[].obs;
  List<FlexeryModel> flexery = [];

  RxList<http.MultipartFile> multiPartImages = <http.MultipartFile>[].obs;

  /// Function to convert file to multipart
  void convertFileToMultipart() async {
    multiPartImages.value = [];
    update();
    for (int i = 0; i < images.length; i++) {
      multiPartImages.add(
        await http.MultipartFile.fromPath('flexeryImage', images[i].path),
      );
    }
    log(':::lengthOfMultiPartImages: ${multiPartImages.length}');
  }

  /// A [TextEditingController] to control the input text for search
  final TextEditingController searchController = TextEditingController();

  ///Function to get images by search
  void getFlexery(String? filter) async {
    showSpinner.value = true;
    await api.getFlexery(filter ?? 'time').then((value) {
      flexery.clear();
      flexery = value;
      showSpinner.value = false;
      if (filter == 'likes') {
        flexeryFilter.value = 0;
      } else if (filter == 'time') {
        flexeryFilter.value = 1;
      } else if (filter == 'random') {
        flexeryFilter.value = 2;
      } else {
        flexeryFilter.value = 1;
      }
      update();
    }).catchError((e) {
      showSpinner.value = false;
      log(':::error: $e');
      Functions.showToast(e.toString());
    });
  }
}
