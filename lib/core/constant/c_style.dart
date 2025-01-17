import 'package:flutter/material.dart';

final class CStyle {
  static BoxDecoration style1() {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(20),
      color: Colors.transparent,
      border: Border.all(color: Colors.blueGrey, width: 2),
    );
  }
}
