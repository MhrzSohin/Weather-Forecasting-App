import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class GetxHelper {
  static showSnackbar({required String message}) {
    Get.showSnackbar(GetSnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white,
      message: message,
      messageText: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
    ));
  }
}
