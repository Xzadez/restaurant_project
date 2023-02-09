import 'package:flutter/material.dart';
import 'package:restaurant_project/common/styles.dart';
import 'package:restaurant_project/data/model/restaurant.dart';
import 'package:restaurant_project/ui/page_detail.dart';
import 'package:restaurant_project/ui/page_home.dart';
import 'package:restaurant_project/ui/page_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurants,
            ),
        SearchPage.routeName: (context) => const SearchPage()
      },
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme),
    );
  }
}
