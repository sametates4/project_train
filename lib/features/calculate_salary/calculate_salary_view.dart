import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/app_state.dart';


@RoutePage()
class CalculateSalaryView extends StatefulWidget {
  const CalculateSalaryView({super.key});

  @override
  State<CalculateSalaryView> createState() => _CalculateSalaryViewState();
}

class _CalculateSalaryViewState extends State<CalculateSalaryView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Maaş Hesapla')),

        );
      },
    );
  }
}
