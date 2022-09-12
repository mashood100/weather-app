import 'package:apis/data/tour.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  List<Tour> listOfTours = allTours;

  cancelSearch() {}

  void searchTour(String qurey) {
    final suggestions = allTours.where((tour) {
      final tourTitle = tour.title.toLowerCase();
      final input = qurey.toLowerCase();

      return tourTitle.contains(input);
    }).toList();

    listOfTours = suggestions;

    update();
  }
}
