import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/data/api/api_service.dart';
import 'package:restaurant_project/provider/all_list_provider.dart';
import 'package:restaurant_project/ui/page_search.dart';
import 'package:restaurant_project/widgets/background.dart';
import 'package:restaurant_project/widgets/card_restoran.dart';
import 'package:restaurant_project/widgets/no_signal.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/result_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _shimmerItem() {
    return ListView.builder(
      itemCount: 7,
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
    return Consumer<RestoProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return _shimmerItem();
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
          itemCount: state.result.restaurants.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var restaurant = state.result.restaurants[index];
            return CardRestoran(
              restaurant: restaurant,
            );
          },
        );
      } else if (state.state == ResultState.NoData) {
        return Center(child: Text(state.message));
      } else if (state.state == ResultState.Error) {
        return const NoSignal();
      } else {
        return const Center(child: Text(''));
      }
    });
  }

  Future<void> _pullRefresh() async {
    return RestoProvider().fetchAllRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Background(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ChangeNotifierProvider(
            create: (_) => RestoProvider(apiService: ApiService()),
            child: RefreshIndicator(
              onRefresh: _pullRefresh,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Daftar Restoran',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.search_rounded,
                              color: Colors.black.withOpacity(0.5),
                              size: 35,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                SearchPage.routeName,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Flexible(
                        child: _buildList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
