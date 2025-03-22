import 'package:get/get.dart';
import '../../configs/app_routes.dart';
import '../models/dto/trip_model.dart';
import '../models/dto/trip_selection_model.dart';

class TripController extends GetxController {
  final RxInt selectedDuration = 1.obs; // Default to 1 day
  final RxList<String> selectedPreferences = <String>[].obs;
  final Rx<TripSelectionModel?> generatedTrip = Rx<TripSelectionModel?>(null);

  // Available preferences
  final List<String> availablePreferences = ['Food', 'Adventure', 'Sightseeing', 'Relaxation'];

  // Toggle preference selection
  void togglePreference(String preference) {
    if (selectedPreferences.contains(preference)) {
      selectedPreferences.remove(preference);
    } else {
      selectedPreferences.add(preference);
    }
  }

  // Generate static itinerary based on duration and preferences
  void generateItinerary() {
    if (selectedPreferences.isEmpty) {
      Get.snackbar('Error', 'Please select at least one preference');
      return;
    }

    List<DayPlan> itinerary = [];
    for (int i = 1; i <= selectedDuration.value; i++) {
      List<String> activities = _getStaticActivities(i, selectedPreferences);
      itinerary.add(DayPlan(day: 'Day $i', activities: activities));
    }

    generatedTrip.value = TripSelectionModel(
      duration: selectedDuration.value,
      preferences: selectedPreferences.toList(),
      itinerary: itinerary,
    );

    Get.toNamed(Routes.itineraryDisplay); // Navigate to display screen
  }

  // Static sample data for activities
  List<String> _getStaticActivities(int day, List<String> preferences) {
    List<String> activities = [];
    if (preferences.contains('Food')) {
      if (day == 1) activities.add('Breakfast at Café Bella');
      if (day == 2) activities.add('Lunch at Spice Haven');
      if (day == 3) activities.add('Dinner at Ocean Grill');
    }
    if (preferences.contains('Adventure')) {
      if (day == 1) activities.add('Hiking at Eagle Peak');
      if (day == 2) activities.add('Kayaking at Blue River');
      if (day == 3) activities.add('Zip-lining at Forest Adventure');
    }
    if (preferences.contains('Sightseeing')) {
      if (day == 1) activities.add('Visit Historic Old Town');
      if (day == 2) activities.add('Tour the City Museum');
      if (day == 3) activities.add('Explore Skyline Lookout');
    }
    if (preferences.contains('Relaxation')) {
      if (day == 1) activities.add('Spa Day at Serenity Retreat');
      if (day == 2) activities.add('Beach Relaxation at Sunset Cove');
      if (day == 3) activities.add('Yoga Session at Calm Studio');
    }
    return activities.isEmpty ? ['Relax and enjoy the day'] : activities;
  }
}