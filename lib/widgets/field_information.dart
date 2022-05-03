import 'package:flutter/material.dart';

class FieldInformation extends StatelessWidget {
  final String label;
  final dynamic value;
  final Icon icon;

  const FieldInformation(
      {required this.label, required this.value, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: icon,
        title: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54)),
        subtitle: Text(
          value,
          style:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
    );
  }
}
