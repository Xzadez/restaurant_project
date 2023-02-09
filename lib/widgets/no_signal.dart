import 'package:flutter/material.dart';

class NoSignal extends StatelessWidget {
  const NoSignal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 140,
          ),
          Image.asset('assets/not_connect.png'),
          Text(
            'No Signal',
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
