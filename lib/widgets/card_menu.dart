import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  final String name;
  const CardMenu({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10, left: 20, right: 8),
          width: MediaQuery.of(context).size.width / 2.45,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        Positioned(
          bottom: 0,
          left: MediaQuery.of(context).size.width / 20,
          child: Container(
            width: MediaQuery.of(context).size.width / 2.45,
            height: MediaQuery.of(context).size.height / 22,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Center(
              child: Text(
                name,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
