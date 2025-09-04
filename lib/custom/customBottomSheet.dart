import 'package:flutter/material.dart';

class customBottomSheet {
  static void showSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
       shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: child,
        );
      },
    );
  }
}