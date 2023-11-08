import 'package:flutter/material.dart';

class DialogUtility {
  static void loadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 300),
          child: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Loading...",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
