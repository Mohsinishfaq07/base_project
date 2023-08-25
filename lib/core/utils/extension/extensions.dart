import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ScaffoldHelper on BuildContext? {
  void show({required String message, Color backgroundColor = Colors.grey}) {
    if (this == null) {
      return;
    }

    ScaffoldMessenger.maybeOf(this!)
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp),
          ),
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 2),
          // shape: const StadiumBorder(),
          // margin: const EdgeInsets.only(bottom: 100, left: 40, right: 40),
          // padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          behavior: SnackBarBehavior.fixed,
        ),
      );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
  String ext() => split('.').last;
  String formatPhone(){
    String sub=replaceAll('-', "").substring(1,11);
    return "92"+sub;
  }

}

extension GetGenderText on int {
  String getGender() {
    if (this == 0) {
      return 'Male';
    } else if (this == 1) {
      return 'Female';
    } else {
      return 'Prefer not to say';
    }
  }
}
