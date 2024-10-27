import 'package:flutter/material.dart';

class SetTime extends StatelessWidget {
  const SetTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text('İş Alma Saati'),

            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('İhtiyat Süresi'),
            ],
          ),
        ],
      ),
    );
  }
}
