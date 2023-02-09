import 'package:flutter/material.dart';

class CardReview extends StatelessWidget {
  final String name;
  final String comment;
  final String date;

  const CardReview(
      {Key? key, required this.name, required this.comment, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 10, left: 20, right: 8),
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 13,
            child: Text(
              comment,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    overflow: TextOverflow.clip,
                    color: Colors.black.withOpacity(0.6),
                  ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  overflow: TextOverflow.clip,
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}
