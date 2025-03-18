import 'package:flutter/material.dart';

class BoxList<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>>? items;
  final String hint;
  final String? Function(T? value)? validator;
  final bool? isExpanded;
  final T? value;
  final void Function(T?)? onChanged;
  final bool? enabled;
  const BoxList({
    super.key,
    this.items,
    required this.hint,
    required this.onChanged,
    this.validator,
    this.isExpanded, this.value, this.enabled
  });

  @override
  BoxListState<T> createState() => BoxListState<T>();
}

class BoxListState<T> extends State<BoxList<T>> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<T>(
        isExpanded: widget.isExpanded ?? false,
        value: widget.value,
        decoration: InputDecoration(
          labelText: widget.hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          enabled: widget.enabled ?? true
        ),
        items: widget.items,
        onChanged: widget.onChanged,
        validator: widget.validator,
      ),
    );
  }
}
