import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SheetHideButton extends StatelessWidget {
  const SheetHideButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
            ),
            child: const Center(
              child: Text('Kapat'),
            )
        ),
      ),
      onTap: () => context.router.popForced(),
    );
  }
}
