// trip_model.dart
class TripSelectionModel {
  final int duration; // Number of days
  final List<String> preferences; // User-selected preferences
  final List<DayPlan> itinerary; // Static itinerary for the trip

  TripSelectionModel({
    required this.duration,
    required this.preferences,
    required this.itinerary,
  });
}

class DayPlan {
  final String day; // e.g., "Day 1"
  final List<String> activities; // List of activities for that day

  DayPlan({
    required this.day,
    required this.activities,
  });
}