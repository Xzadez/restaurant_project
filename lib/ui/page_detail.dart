import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/data/api/api_service.dart';
import 'package:restaurant_project/data/api/image_url.dart';
import 'package:restaurant_project/provider/detail_provider.dart';
import 'package:restaurant_project/widgets/card_menu.dart';
import 'package:restaurant_project/widgets/card_rating.dart';
import 'package:restaurant_project/widgets/card_review.dart';
import 'package:restaurant_project/widgets/custom_button.dart';
import 'package:restaurant_project/widgets/no_signal.dart';
import 'package:restaurant_project/widgets/tag.dart';

import '../data/model/restaurant.dart';
import '../provider/add_review_provider.dart';
import '../provider/result_state.dart';
import '../widgets/custom_textfield.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/resto_detail';

  final Restaurants? restaurant;

  const DetailPage({Key? key, this.restaurant}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ImageUrl _urlImage = ImageUrl();

  TextEditingController nameController = TextEditingController();

  TextEditingController reviewController = TextEditingController();

  Widget _backBtn(context) {
    return GestureDetector(
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_rounded,
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _image(double? width) {
    return Hero(
      tag: widget.restaurant!.pictureId,
      child: Image.network(
        // ignore: prefer_if_null_operators, unnecessary_null_comparison
        _urlImage.meduim + widget.restaurant!.pictureId == null
            ? _urlImage.meduim + widget.restaurant!.pictureId
            : _urlImage.meduim + widget.restaurant!.pictureId,
        width: width,
      ),
    );
  }

  Widget _title(String name, String city, double rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.location_pin,
                    size: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    city,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Colors.grey,
                        ),
                  )
                ],
              ),
            ],
          ),
          CardRating(
            rating: rating.toString(),
          )
        ],
      ),
    );
  }

  Widget _tags(List nameTag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 56,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        itemCount: nameTag.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Tag(nameTag: nameTag[index].name);
        },
      ),
    );
  }

  Widget _deskripsi(String deskripsi) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Deskripsi :',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            deskripsi,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Colors.black.withOpacity(0.5),
                ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _menu(String? text, List name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            text!,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CardMenu(
              name: name[index].name,
            ),
          ),
        ),
      ],
    );
  }

  Widget _review(List reviews, context) {
    final addProv = Provider.of<AddReviewProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Customer Reviews',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: addProv.isAdding == true
                ? addProv.addReview?.customerReviews.length
                : reviews.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CardReview(
              name: addProv.isAdding == true
                  ? addProv.addReview?.customerReviews[index].name
                  : reviews[index].name,
              comment: addProv.isAdding == true
                  ? addProv.addReview?.customerReviews[index].review
                  : reviews[index].review,
              date: addProv.isAdding == true
                  ? addProv.addReview?.customerReviews[index].date
                  : reviews[index].date,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _buttonReview(context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,
      child: CustomButton(
        borderRadius: BorderRadius.circular(24),
        text: 'Tambahkan Ulasan',
        onPressed: () {
          _showingDialog(context);
        },
      ),
    );
  }

  void _showingDialog(context) {
    final addProv = Provider.of<AddReviewProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 420,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Name',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: nameController,
                  colorContainer: Colors.black.withOpacity(0.1),
                  hintText: 'Your Name...',
                  textInputAction: TextInputAction.next,
                  maxLength: 28,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Feedback',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: reviewController,
                  colorContainer: Colors.black.withOpacity(0.1),
                  hintText: 'Type Here...',
                  textInputAction: TextInputAction.done,
                  maxLength: 120,
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    borderRadius: BorderRadius.circular(24),
                    text: 'Submit',
                    onPressed: () {
                      addProv.addReviewRestaurant(
                        ApiService(),
                        widget.restaurant!.id,
                        nameController.text,
                        reviewController.text,
                      );
                      Navigator.pop(context);

                      showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(
                                const Duration(seconds: 1, milliseconds: 2000),
                                () {
                              Navigator.pop(context);
                            });
                            return Lottie.asset('assets/done.json');
                          });

                      Future.delayed(const Duration(seconds: 1), () {
                        addProv.isAdding = true;
                      });

                      nameController.clear();
                      reviewController.clear();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DetailProvider(
            apiService: ApiService(),
            id: widget.restaurant!.id,
          ),
        ),
        ChangeNotifierProvider(create: (_) => AddReviewProvider())
      ],
      child: SafeArea(
          child: Scaffold(
        body: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: <Widget>[
              _image(width),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _backBtn(context),
                    ),
                    SizedBox(
                      height: height / 5.5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 24),
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Consumer<DetailProvider>(
                        builder: (context, state, _) {
                          if (state.state == ResultState.Loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state.state == ResultState.HasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _title(
                                    state.detailResult!.restaurant.name,
                                    state.detailResult!.restaurant.city,
                                    state.detailResult!.restaurant.rating),
                                _tags(
                                    state.detailResult!.restaurant.categories),
                                _deskripsi(
                                    state.detailResult!.restaurant.description),
                                _menu('Menu Makanan',
                                    state.detailResult!.restaurant.menus.foods),
                                const SizedBox(
                                  height: 20,
                                ),
                                _menu(
                                    'Menu Minuman',
                                    state
                                        .detailResult!.restaurant.menus.drinks),
                                const SizedBox(
                                  height: 20,
                                ),
                                _review(
                                    state.detailResult!.restaurant
                                        .customerReviews,
                                    context),
                                _buttonReview(context),
                              ],
                            );
                          } else if (state.state == ResultState.NoData) {
                            return Center(child: Text(state.message));
                          } else if (state.state == ResultState.Error) {
                            return const NoSignal();
                          } else {
                            return const Center(child: Text(''));
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
