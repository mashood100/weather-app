import 'package:apis/modules/search/controller/search_screen_controller.dart';
import 'package:apis/data/tour.dart';
import 'package:apis/modules/current%20weather/view/current_weather_screen.dart';

import 'package:apis/modules/search/view/widgets/noresultfound.dart';
import 'package:apis/modules/search/view/widgets/search_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  // final SearchScreenController _screenController =
  //     Get.put(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<SearchScreenController>(
          init: SearchScreenController(),
          builder: (_controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.11,
                ),
                SearchFeild(
                    screenController: _controller,
                    textController: _searchTextController),
                _searchTextController.text.isNotEmpty &&
                        _controller.listOfTours.isEmpty
                    ? const NoResultFound()
                    : _AllTourResults(
                        listOfTour: _controller.listOfTours,
                      )
              ],
            );
          }),
    );
  }
}

class _AllTourResults extends StatelessWidget {
  final List<Tour> listOfTour;
  const _AllTourResults({Key? key, required this.listOfTour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: listOfTour.length,
              itemBuilder: (context, index) {
                return _EachCityResultTile(
                  tourDetails: listOfTour[index],
                );
              }),
        ),
      ],
    ));
  }
}

class _EachCityResultTile extends StatelessWidget {
  final Tour tourDetails;

  const _EachCityResultTile({
    Key? key,
    required this.tourDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offAll(() => const WeatherDetail(), arguments: tourDetails);
      },
      child: ListTile(
        title: Text(tourDetails.title,
            style: TextStyle(color: Colors.white.withOpacity(0.8))),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            tourDetails.country,
            style: TextStyle(color: Colors.white.withOpacity(0.6)),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_outlined,
          color: Colors.orange.withOpacity(0.7),
        ),
      ),
    );
  }
}
