// popup.dart
import 'package:flutter/material.dart';
import 'dart:html' as html;

class PopupScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    html.document.title = 'Custom Popup Title';
    return Scaffold(

      body: Center(
        child: Container(
         color: Colors.green,
        ),
      ),
    );
  }
}
