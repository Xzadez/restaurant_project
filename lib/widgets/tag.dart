import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String nameTag;
  const Tag({Key? key, required this.nameTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, right: 10),
      width: 95,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(nameTag, style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}
