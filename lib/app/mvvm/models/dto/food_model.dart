// food_model.dart
class Food {
  final String id; // Unique identifier for the food item
  final String name; // Name of the dish (e.g., "Margherita Pizza")
  final String cuisine; // Type of cuisine (e.g., "Italian", "Mexican")
  final String description; // Brief description of the dish
  final double rating; // User rating out of 5 (e.g., 4.7)
  final double price; // Price in dollars (e.g., 12.99)
  final List<String> images; // List of image URLs for the dish
  final List<String> videoUrls; // List of video URLs (e.g., cooking demos)
  final List<String> ingredients; // Key ingredients in the dish
  final List<String> tags; // Hashtags or categories (e.g., "#vegan")
  final String songName; // Associated song name (for thematic consistency)
  final String artistName; // Artist of the associated song

  Food({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.description,
    required this.rating,
    required this.price,
    required this.images,
    required this.videoUrls,
    required this.ingredients,
    required this.tags,
    required this.songName,
    required this.artistName,
  });

  // Factory constructor for an empty/default Food object
  factory Food.empty() => Food(
    id: '',
    name: '',
    cuisine: '',
    description: '',
    rating: 0.0,
    price: 0.0,
    images: [],
    videoUrls: [],
    ingredients: [],
    tags: [],
    songName: '',
    artistName: '',
  );
}