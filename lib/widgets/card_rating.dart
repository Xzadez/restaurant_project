import 'package:flutter/material.dart';

class CardRating extends StatelessWidget {
  final String rating;

  const CardRating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 70,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(1, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.star_rate_rounded,
            color: Colors.yellow.shade700,
            size: 22,
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            rating,
          )
        ],
      ),
    );
  }
}
