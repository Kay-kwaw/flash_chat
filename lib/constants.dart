import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 155, 108, 247);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color accentColor = Color(0xFFFF4081);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color textColor = Color.fromARGB(255, 209, 156, 86);
  static const Color hintColor = Color.fromARGB(255, 202, 113, 113);
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),

      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final String placeholder;
  final double height;

  const CustomTextField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.placeholder,
     required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: height,
          child: TextField(
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 237, 237, 237),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              hintText: placeholder,
            ),
            onChanged: onChanged,
            controller: TextEditingController(text: value),
          ),
        ),
      ],
    );
  }
}
