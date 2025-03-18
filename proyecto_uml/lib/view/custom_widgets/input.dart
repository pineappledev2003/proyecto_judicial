import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? validator;
  final bool? enable;
  final bool? filled;
  final TextStyle? style;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final bool? readOnly;
  final void Function()? onTap;
  final String? initialValue;
  const CustomInput({
    super.key,
    this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.validator,
    this.enable,
    this.filled,
    this.style,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.onChanged, this.readOnly, this.onTap, this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        onSaved: onSaved,
        enabled: enable,
        readOnly: readOnly ?? false ,
        validator: validator,
        maxLength: maxLength,
        onChanged: onChanged,
        initialValue: initialValue,
        onTap: onTap,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder(), filled: filled),
        style: style,
      ),
    );
  }
}
