import 'package:flutter/material.dart';

class CustomSelector extends StatefulWidget {
  const CustomSelector({
    super.key,
    required this.opciones,
    this.onChanged,
  });

  final List<DropdownMenuItem<String>> opciones;
  final Function(String)? onChanged;

  @override
  State<CustomSelector> createState() => _CustomSelectorState();
}

class _CustomSelectorState extends State<CustomSelector> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.opciones.first.value!;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selected,
      icon: Expanded(
        child: Container(
            alignment: Alignment.bottomRight,
            child: const Icon(Icons.arrow_downward)),
      ),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? value) {
        setState(() {
          selected = value!;
        });

        if (widget.onChanged != null) {
          widget.onChanged!(value!);
        }
      },
      items: widget.opciones,
    );
  }
}
