import 'package:flutter/material.dart';

import '../../widget/sheet_hide_button.dart';

mixin sheetService on State {
  void showMainSheet({required Widget child}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: child,
            ),
            const SheetHideButton(),
          ],
        );
      },
    );
  }
}
