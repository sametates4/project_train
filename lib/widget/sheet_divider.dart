import 'package:flutter/material.dart';

mixin SheetDivider {
  static showDivider() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10,),
        Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}