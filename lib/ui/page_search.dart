import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/provider/search_provider.dart';
import 'package:restaurant_project/widgets/background.dart';
import 'package:restaurant_project/widgets/card_restoran.dart';
import 'package:restaurant_project/widgets/custom_textfield.dart';
import 'package:restaurant_project/widgets/platform_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../data/api/api_service.dart';
import '../provider/all_list_provider.dart';
import '../provider/result_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  static const routeName = '/resto_search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  RestoProvider restoProvider = RestoProvider();

  Widget _shimmerItem() {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer(
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade300,
              Colors.white,
              Colors.grey.shade300,
            ],
          ),
          child: const CardRestoran(),
        );
      },
    );
  }

  Widget _buildList() {
    return Consumer<SearchProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return _shimmerItem();
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
          itemCount: state.searchResults!.restaurants.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var restaurant = state.searchResults!.restaurants[index];
            return CardRestoran(
              restaurant: restaurant,
            );
          },
        );
      } else if (state.state == ResultState.NoData) {
        return Center(
            child: Column(
          children: <Widget>[
            Image.asset('assets/not_found.png'),
            Text(
              state.message,
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ));
      } else if (state.state == ResultState.Error) {
        return Center(child: Image.asset('assets/find.png'));
      } else {
        return Center(child: Image.asset('assets/find.png'));
      }
    });
  }

  Widget _androidBuilder(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, state, _) => CustomTextField(
        textInputAction: TextInputAction.done,
        hintText: 'Cari Restoran...',
        icon: const Icon(
          Icons.search_rounded,
          color: Colors.grey,
        ),
        onChanged: (value) {
          state.searchRestaurant(ApiService(), value);
        },
      ),
    );
  }

  Widget _iosBuilder(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, state, _) => CupertinoSearchTextField(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        onChanged: (value) {
          state.searchRestaurant(ApiService(), value);
        },
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ChangeNotifierProvider(
          create: (_) => SearchProvider(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Search',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PlatformWidget(
                    androidBuilder: _androidBuilder,
                    iosBuilder: _iosBuilder,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: _buildList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
