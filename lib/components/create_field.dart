import 'package:flutter/material.dart';

Widget createField(String label, TextEditingController controller,
    [bool passwd = false, bool text = false]) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter a valid input!';
        }
        return null;
      },
      minLines: text ? 5 : 1,
      maxLines: text ? 5 : 1,
      decoration: InputDecoration(
        label: Text(label),
        border: const OutlineInputBorder(),
        helperText: "Enter your $label",
      ),
      obscureText: passwd,
    ),
  );
}
