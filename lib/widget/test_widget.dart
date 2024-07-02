import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  double position = 0.0;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.white,
      child: Column(
        children: [
          Positioned(
            left: position,
            top: 1,
            child: Draggable(
              axis: Axis.horizontal,
              feedback: Container(
                width: 150,
                height: 50,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Kayıt Ol Lan',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              childWhenDragging: Container(),
              child: Container(
                width: 150,
                height: 50,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Kayıt Ol Gevşek',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              onDragEnd: (details) {
                print(details.offset.dx);
                setState(() {
                  position = details.offset.dx;
                  if (position >= maxWidth - 150) {
                    // Buton yeterince sağa sürüklenmişse kayıt işlemini gerçekleştir
                    print('object');
                  } else {
                    // Buton sürüklenmiş ancak yeterince değilse başa dön
                    position = 0.0;
                    print('afawdadw');
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
