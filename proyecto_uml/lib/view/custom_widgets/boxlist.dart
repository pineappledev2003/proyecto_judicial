import 'package:flutter/material.dart';

class BoxList extends StatefulWidget {
  final List<String> items;
  final String hint;
  final ValueChanged<String?> onChanged;

  const BoxList({
    super.key,
    required this.items,
    required this.hint,
    required this.onChanged,
  });

  @override
  _BoxListState createState() => _BoxListState();
}

class _BoxListState extends State<BoxList> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: widget.hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}
