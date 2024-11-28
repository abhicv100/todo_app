import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;

  final String text;

  final IconData? icon;

  final bool isEnabled;

  const PrimaryButton({super.key, required this.onPressed, required this.text, this.icon, this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onPressed: null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: isEnabled ? Colors.amberAccent: Colors.black12,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: 50,
        child: Row(
            mainAxisAlignment: icon == null ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0, color: Colors.black87),
              ),
              (icon != null) ? Icon(icon, color: Colors.black87, size: 30,) : const SizedBox(),
            ],
          ),
      ),
    );
  }
}
