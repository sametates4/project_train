import 'package:flutter/material.dart';

final class ContainerDecoration {
  static BoxDecoration appointmentCard() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            blurStyle: BlurStyle.normal,
            offset: const Offset(-5, 5))
      ],
    );
  }
}