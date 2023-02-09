import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.borderRadius = BorderRadius.zero,
    this.onPressed,
    this.text,
  }) : super(key: key);

  final BorderRadiusGeometry borderRadius;
  final void Function()? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      onPressed: onPressed,
      child: Text(
        text ?? '',
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
