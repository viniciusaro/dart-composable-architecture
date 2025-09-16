import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  final String value;
  final void Function(String) onChanged;

  const DefaultTextField({
    super.key,
    this.value = "",
    required this.onChanged, //
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value;
    _controller.addListener(() {
      widget.onChanged(_controller.text);
    });
  }

  @override
  void didUpdateWidget(covariant DefaultTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && widget.value != _controller.text) {
      _controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: _controller,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
