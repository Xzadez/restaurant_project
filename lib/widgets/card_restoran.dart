import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_project/data/api/image_url.dart';
import 'package:restaurant_project/data/model/restaurant.dart';
import 'package:restaurant_project/ui/page_detail.dart';
import 'package:shimmer/shimmer.dart';

class CardRestoran extends StatelessWidget {
  final Restaurants? restaurant;

  const CardRestoran({
    Key? key,
    this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailPage.routeName,
        arguments: restaurant,
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(1, 1),
                  blurRadius: 3.5,
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width * 0.33),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      restaurant?.name ?? '',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.location_pin,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          restaurant?.city ?? '',
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star_rate_rounded,
                          size: 22,
                          color: Colors.yellow.shade700,
                        ),
                        Text(restaurant?.rating.toString() ?? '')
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            left: 15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: restaurant?.pictureId != null
                  ? CachedNetworkImage(
                      placeholder: (context, url) => Shimmer(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.12,
                          color: Colors.white,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.shade300,
                            Colors.white,
                            Colors.grey.shade300
                          ],
                        ),
                      ),
                      imageUrl: ImageUrl().small + restaurant!.pictureId,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.12,
                    )
                  : Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
