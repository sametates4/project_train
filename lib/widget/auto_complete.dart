import 'package:flutter/material.dart';

class AutoComplete extends StatefulWidget {
  const AutoComplete(
      {super.key,
        required this.list,
        required this.controller,
        this.labelText,
        this.inputAction,
        this.inputType});

  final List<dynamic> list;
  final TextEditingController controller;
  final String? labelText;
  final TextInputType? inputType;
  final TextInputAction? inputAction;

  @override
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  String _suggestion = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        TextField(
            controller: TextEditingController(text: _suggestion),
            style: const TextStyle(color: Colors.grey),
            textInputAction: widget.inputAction,
            keyboardType: widget.inputType,
            enabled: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            )),
        TextField(
          controller: widget.controller,
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          onChanged: (value) {
            if (value.length == 0) {
              setState(() {
                _suggestion = "";
              });
            } else {
              final match = widget.list.firstWhere(
                    (s) => s.toLowerCase().startsWith(value.toLowerCase()),
                orElse: () => '',
              );
              setState(() {
                _suggestion = match;
              });
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            labelText: widget.labelText,
          ),
          onSubmitted: (_) { // Kullanıcı "Next" tuşuna bastığında tetiklenir
            setState(() {
              widget.controller.text = _suggestion;
              widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller.text.length),
              );
            });
          },
        ),
      ],
    );
  }
}