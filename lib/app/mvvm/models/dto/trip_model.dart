class Trip {
  final String id;
  final String name;
  final String imageUrl;
  final String startDate;
  final String endDate;
  final List<String> destinations;
  final bool isRecommendation;
  final bool isSaved;

  Trip({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.destinations,
    required this.isRecommendation,
    required this.isSaved,
  });
}
