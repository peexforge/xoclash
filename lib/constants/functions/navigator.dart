import 'package:flutter/material.dart';

// Navigates between pages ( Goes to a page and backs from a page )
class Nav {
  void gotoPage(Widget page, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void back(BuildContext context) {
    Navigator.pop(context);
  }
}
