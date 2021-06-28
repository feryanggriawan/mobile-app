import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:unicons/unicons.dart';

void snackbarWidget(
    {Color backgroundColor,
    Color iconColor,
    IconData icon,
    String titleText,
    String messageText}) {
  Get.snackbar("", "",
      backgroundColor: (backgroundColor != null) ? backgroundColor : error,
      icon: Icon(
        (icon != null) ? icon : UniconsLine.times_circle,
        color: (iconColor != null) ? iconColor : Colors.white,
      ),
      titleText: Text(titleText ?? "",
          style: ralewayTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white)),
      messageText: Text(messageText ?? "", style: ralewayTextStyle.copyWith(color: Colors.white)));
}
