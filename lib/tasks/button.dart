import 'package:flutter/material.dart';

class SuperButton extends StatefulWidget {
  const SuperButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.onPress,
      required this.color});
  final String label;
  final IconData icon;
  final Function()? onPress;
  final Color color;
  @override
  State<SuperButton> createState() => _SuperButtonState();
}

class _SuperButtonState extends State<SuperButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(widget.label, style: const TextStyle(fontSize: 20)),
      icon: Icon(widget.icon, size: 25),
      onPressed: widget.onPress,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(widget.color),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        ),
      ),
    );
  }
}
