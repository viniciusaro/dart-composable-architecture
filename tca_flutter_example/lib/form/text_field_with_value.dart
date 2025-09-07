import 'package:flutter/material.dart';

final class TextFieldWithValue extends StatefulWidget {
  final String? value;
  final String? hintText;
  final void Function(String) onChanged;

  const TextFieldWithValue({
    super.key,
    required this.value,
    this.hintText,
    required this.onChanged,
  });

  @override
  State<TextFieldWithValue> createState() => _TextFieldWithValueState();
}

class _TextFieldWithValueState extends State<TextFieldWithValue> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value ?? '';
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    widget.onChanged(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        label: Text(widget.hintText ?? ''),
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }
}
