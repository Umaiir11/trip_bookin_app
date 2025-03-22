import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/dto/food_model.dart';

class FoodController extends GetxController {
  final Rx<Food> food = Food.empty().obs;
  final RxBool isLoading = true.obs;
  final RxBool isFavorite = false.obs;
  final RxList<Food> foodsList = <Food>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeFoods();
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    // Add favorite logic here if needed
  }

  // Initialize the foods list with 10 sample foods
  void initializeFoods() {
    foodsList.value = [
      Food(
        id: '1',
        name: 'Margherita Pizza',
        cuisine: 'Italian',
        description: 'Classic pizza with fresh tomatoes and mozzarella',
        rating: 4.7,
        price: 12.99,
        images: [
          'https://images.pexels.com/photos/2147491/pexels-photo-2147491.jpeg?auto=compress&cs=tinysrgb&w=300',
          'https://images.unsplash.com/photo-1604068549290-dea0e4b44da3?auto=format&fit=crop&w=300',
        ],
        videoUrls: ['https://example.com/food-video-1.mp4'],
        ingredients: ['Tomato', 'Mozzarella', 'Basil', 'Olive Oil'],
        tags: ['#italian', '#pizza'],
        songName: 'That’s Amore',
        artistName: 'Dean Martin',
      ),
      Food(
        id: '2',
        name: 'Tacos al Pastor',
        cuisine: 'Mexican',
        description: 'Spicy pork tacos with pineapple and cilantro',
        rating: 4.8,
        price: 9.99,
        images: [
          'https://images.pexels.com/photos/761854/pexels-photo-761854.jpeg?auto=compress&cs=tinysrgb&w=300',
          'https://images.unsplash.com/photo-1551504734-5ee1c4a14705?auto=format&fit=crop&w=300',
        ],
        videoUrls: ['https://example.com/food-video-2.mp4'],
        ingredients: ['Pork', 'Pineapple', 'Cilantro', 'Chili'],
        tags: ['#mexican', '#tacos'],
        songName: 'La Bamba',
        artistName: 'Ritchie Valens',
      ),
      Food(
        id: '3',
        name: 'Sushi Platter',
        cuisine: 'Japanese',
        description: 'Fresh assortment of nigiri and maki rolls',
        rating: 4.9,
        price: 24.99,
        images: [
          'https://images.pexels.com/photos/209808/pexels-photo-209808.jpeg?auto=compress&cs=tinysrgb&w=300',
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=300',
        ],
        videoUrls: ['https://example.com/food-video-3.mp4'],
        ingredients: ['Salmon', 'Tuna', 'Rice', 'Seaweed'],
        tags: ['#japanese', '#sushi'],
        songName: 'Sakura',
        artistName: 'Ikue Asazaki',
      ),
      Food(
        id: '4',
        name: 'Butter Chicken',
        cuisine: 'Indian',
        description: 'Creamy chicken curry with rich spices',
        rating: 4.6,
        price: 15.49,
        images: [
          'https://images.pexels.com/photos/674574/pexels-photo-674574.jpeg?auto=compress&cs=tinysrgb&w=300',
          'https://images.unsplash.com/photo-1589302168068-379598016c91?auto=format&fit=crop&w=300',
        ],
        videoUrls: ['https://example.com/food-video-4.mp4'],
        ingredients: ['Chicken', 'Butter', 'Tomato', 'Cream'],
        tags: ['#indian', '#curry'],
        songName: 'Jai Ho',
        artistName: 'A.R. Rahman',
      ),
      Food(
        id: '5',
        name: 'Burger Deluxe',
        cuisine: 'American',
        description: 'Juicy beef burger with all the fixings',
        rating: 4.5,
        price: 11.99,
        images: [
          'https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg?auto=compress&cs=tinysrgb&w=300',
          'https://images.unsplash.com/photo-1550317138-10000687a72b?auto=format&fit=crop&w=300',
        ],
        videoUrls: ['https://example.com/food-video-5.mp4'],
        ingredients: ['Beef', 'Lettuce', 'Tomato', 'Cheese'],
        tags: ['#american', '#burger'],
        songName: 'Sweet Home Alabama',
        artistName: 'Lynyrd Skynyrd',
      ),
      Food(
        id: '6',
        name: 'Pad Thai',
        cuisine: 'Thai',
        description: 'Stir-fried noodles with shrimp and peanuts',
        rating: 4.7,
        price: 13.99,
        images: [
          'https://images.pexels.com/photos/699953/pexels-photo-699953.jpeg?auto=compress&cs=tinysrgb&w=300',
          'https://images.unsplash.com/photo-1617093727341-3747e3e2b359?auto=format&fit=crop&w=300',
        ],
        videoUrls: ['https://example.com/food-video-6.mp4'],
        ingredients: ['Noodles', 'Shrimp', 'Peanuts', 'Lime'],
        tags: ['#thai', '#noodles'],
        songName: 'Thailand',
        artistName: 'BØRNS',
      ),
      Food(
        id: '7',
        name: 'Croissant',
        cuisine: 'French',
        description: 'Flaky, buttery pastry perfection',
        rating: 4.6,
        price: 4.99,
        images: [
          'https://images.pexels.com/photos/3892469/pexels-photo-3892469.jpeg?auto=compress&cs=tinysrgb&w=300',
          'https://images.unsplash.com/photo-1602253057119-44d745d9b860?auto=format&fit=crop&w=300',
        ],
        videoUrls: ['https://example.com/food-video-7.mp4'],
        ingredients: ['Butter', 'Flour', 'Sugar'],
        tags: ['#french', '#pastry'],
        songName: 'La Vie en Rose',
        artistName: 'Édith Piaf',
      ),
      Food(
        id: '8',
        name: 'Paella',
        cuisine: 'Spanish',
        description: 'Saffron-infused rice with seafood',
        rating: 4.8,
        price: 19.99,
        images: [
          'https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=300',
          'https://images.unsplash.com/photo-1608222375898-5e3a1ba8e741?auto=format&fit=crop&w=300',
        ],
        videoUrls: ['https://example.com/food-video-8.mp4'],
        ingredients: ['Rice', 'Shrimp', 'Saffron', 'Peas'],
        tags: ['#spanish', '#seafood'],
        songName: 'Bailando',
        artistName: 'Enrique Iglesias',
      ),
      Food(
        id: '9',
        name: 'Pho',
        cuisine: 'Vietnamese',
        description: 'Aromatic beef noodle soup',
        rating: 4.7,
        price: 10.99,
        images: [
          'https://images.pexels.com/photos/699953/pexels-photo-699953.jpeg?auto=compress&cs=tinysrgb&w=300',
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=300',
        ],
        videoUrls: ['https://example.com/food-video-9.mp4'],
        ingredients: ['Beef', 'Noodles', 'Cinnamon', 'Basil'],
        tags: ['#vietnamese', '#soup'],
        songName: 'Saigon',
        artistName: 'Luke Hemmings',
      ),
      Food(
        id: '10',
        name: 'Falafel Wrap',
        cuisine: 'Middle Eastern',
        description: 'Crispy falafel in a warm pita',
        rating: 4.6,
        price: 8.99,
        images: [
          'https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&w=300',
          'https://images.unsplash.com/photo-1603046899799-208763b0a359?auto=format&fit=crop&w=300',
        ],
        videoUrls: ['https://example.com/food-video-10.mp4'],
        ingredients: ['Chickpeas', 'Tahini', 'Pita', 'Lettuce'],
        tags: ['#middleeastern', '#vegan'],
        songName: 'Habibi',
        artistName: 'Tamino',
      ),
    ];  }

  // Fetch food by ID
  Future<void> getFoodById(String foodId) async {
    isLoading.value = true;
    try {
      // await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

      // Find food in the list
      final foundFood = foodsList.firstWhere(
            (f) => f.id == foodId,
        orElse: () => Food.empty(),
      );

      if (foundFood.id.isNotEmpty) {
        food.value = foundFood;
      } else {
        throw Exception('Food not found with ID: $foodId');
      }
    } catch (e) {
      print('Error fetching food by ID: $e');
      food.value = Food.empty();
      Get.snackbar(
        'Error',
        'Could not find food with ID: $foodId',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}