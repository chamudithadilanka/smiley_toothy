import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  String? selectedGender;
  CustomDropdown({super.key, required this.selectedGender});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.selectedGender,
      hint: Text("Select"),
      items:
          ["Male", "Female"].map((item) {
            return DropdownMenuItem(child: Text(item), value: item);
          }).toList(),
      onChanged: (value) {
        widget.selectedGender = value;
      },
    );
  }
}
