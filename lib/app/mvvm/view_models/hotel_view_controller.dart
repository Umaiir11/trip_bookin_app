import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/dto/hotel_model.dart';
import 'dto_class.dart'; // Assuming this contains DummyDataProvider

class HotelController extends GetxController {
  final Rx<Hotel> hotel = Hotel.empty().obs;
  final RxBool isLoading = true.obs;
  final RxList<Hotel> hotelsList = <Hotel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeHotels();
    // fetchHotelDetails();
  }

  // Initialize the hotels list with 10 sample hotels
  void initializeHotels() {
    hotelsList.value = [
      Hotel(
        id: '1',
        name: 'Level Chicago - River North',
        location: 'Chicago, Illinois',
        description: 'Luxury living in the heart of River North',
        rating: 4.8,
        price: 299,
        images: [
          'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa',
          'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af',
        ],
        videoUrls: ['https://example.com/hotel-video-1.mp4'],
        amenities: ['Pool', 'Gym', 'Spa', 'Free WiFi'],
        tags: ['#chicago', '#luxury'],
        songName: 'Sunset Lover',
        artistName: 'Petit Biscuit',
      ),
      Hotel(
        id: '2',
        name: 'Ocean Breeze Resort',
        location: 'Miami, Florida',
        description: 'Beachfront luxury with stunning ocean views',
        rating: 4.6,
        price: 249,
        images: [
          'https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9',
          'https://images.unsplash.com/photo-1566073771259-6a8506099945',
        ],
        videoUrls: ['https://example.com/hotel-video-2.mp4'],
        amenities: ['Beach', 'Pool', 'Spa', 'Restaurant'],
        tags: ['#miami', '#beach'],
        songName: 'Ocean Drive',
        artistName: 'Duke Dumont',
      ),
      Hotel(
        id: '3',
        name: 'Mountain View Lodge',
        location: 'Aspen, Colorado',
        description: 'Cozy retreat with mountain views',
        rating: 4.7,
        price: 320,
        images: [
          'https://images.unsplash.com/photo-1542314831-8d54a42f2957',
          'https://images.unsplash.com/photo-1518732714860-b62714ce0c59',
        ],
        videoUrls: ['https://example.com/hotel-video-3.mp4'],
        amenities: ['Ski Access', 'Fireplace', 'Hot Tub'],
        tags: ['#aspen', '#mountain'],
        songName: 'The Night',
        artistName: 'The Weeknd',
      ),
      Hotel(
        id: '4',
        name: 'Desert Oasis',
        location: 'Palm Springs, California',
        description: 'Modern luxury in the desert',
        rating: 4.5,
        price: 280,
        images: [
          'https://images.unsplash.com/photo-1564501049412-3d4034e6d8e5',
          'https://images.unsplash.com/photo-1549638441-b78e8fcee9f5',
        ],
        videoUrls: ['https://example.com/hotel-video-4.mp4'],
        amenities: ['Pool', 'Golf', 'Spa', 'Free WiFi'],
        tags: ['#desert', '#luxury'],
        songName: 'Midnight City',
        artistName: 'M83',
      ),
      Hotel(
        id: '5',
        name: 'City Lights Hotel',
        location: 'New York, New York',
        description: 'Urban luxury with skyline views',
        rating: 4.9,
        price: 399,
        images: [
          'https://images.unsplash.com/photo-1566073771259-6a8506099945',
          'https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9',
        ],
        videoUrls: ['https://example.com/hotel-video-5.mp4'],
        amenities: ['Rooftop', 'Gym', 'Restaurant'],
        tags: ['#newyork', '#city'],
        songName: 'Empire State of Mind',
        artistName: 'Jay-Z',
      ),
      Hotel(
        id: '6',
        name: 'Pacific Paradise',
        location: 'Honolulu, Hawaii',
        description: 'Tropical luxury by the beach',
        rating: 4.8,
        price: 350,
        images: [
          'https://images.unsplash.com/photo-1570213489059-0a0b9e6e5d86',
          'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa',
        ],
        videoUrls: ['https://example.com/hotel-video-6.mp4'],
        amenities: ['Beach', 'Pool', 'Luau', 'Spa'],
        tags: ['#hawaii', '#paradise'],
        songName: 'Island in the Sun',
        artistName: 'Weezer',
      ),
      Hotel(
        id: '7',
        name: 'Historic Grande',
        location: 'Boston, Massachusetts',
        description: 'Classic elegance in historic district',
        rating: 4.6,
        price: 275,
        images: [
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
          'https://images.unsplash.com/photo-1590073844006-33379778ae09',
        ],
        videoUrls: ['https://example.com/hotel-video-7.mp4'],
        amenities: ['Library', 'Restaurant', 'Free WiFi'],
        tags: ['#boston', '#historic'],
        songName: 'Boston',
        artistName: 'Augustana',
      ),
      Hotel(
        id: '8',
        name: 'Sunset Cliffs Inn',
        location: 'San Diego, California',
        description: 'Coastal retreat with ocean views',
        rating: 4.7,
        price: 265,
        images: [
          'https://images.unsplash.com/photo-1563911596931-25811d4c4926',
          'https://images.unsplash.com/photo-1570213489059-0a0b9e6e5d86',
        ],
        videoUrls: ['https://example.com/hotel-video-8.mp4'],
        amenities: ['Beach Access', 'Pool', 'Gym'],
        tags: ['#sandiego', '#coastal'],
        songName: 'Californication',
        artistName: 'Red Hot Chili Peppers',
      ),
      Hotel(
        id: '9',
        name: 'Lakefront Retreat',
        location: 'Seattle, Washington',
        description: 'Serenity by the lake',
        rating: 4.5,
        price: 245,
        images: [
          'https://images.unsplash.com/photo-1513635269976-827c7cf2c905',
          'https://images.unsplash.com/photo-1549638441-b78e8fcee9f5',
        ],
        videoUrls: ['https://example.com/hotel-video-9.mp4'],
        amenities: ['Lake View', 'Spa', 'Restaurant'],
        tags: ['#seattle', '#lake'],
        songName: 'Come As You Are',
        artistName: 'Nirvana',
      ),
      Hotel(
        id: '10',
        name: 'Golden Sands Resort',
        location: 'Las Vegas, Nevada',
        description: 'Luxury in the entertainment capital',
        rating: 4.8,
        price: 340,
        images: [
          'https://images.unsplash.com/photo-1548585743-5f3c4e1a0369',
          'https://images.unsplash.com/photo-1546410531-18626b707e96',
        ],
        videoUrls: ['https://example.com/hotel-video-10.mp4'],
        amenities: ['Casino', 'Pool', 'Shows', 'Spa'],
        tags: ['#vegas', '#luxury'],
        songName: 'Viva Las Vegas',
        artistName: 'Elvis Presley',
      ),
    ];
  }

  // Fetch all hotels (initial load)
  // void fetchHotelDetails() async {
  //   isLoading.value = true;
  //   try {
  //     await Future.delayed(const Duration(milliseconds: 800)); // Simulate network delay
  //     if (hotelsList.isEmpty) {
  //       initializeHotels();
  //     }
  //     // If coming from navigation with hotelId
  //     final hotelId = Get.arguments?['hotelId'] as String?;
  //     if (hotelId != null) {
  //       await getHotelById(hotelId);
  //     } else {
  //       hotel.value = hotelsList.first; // Default to first hotel
  //     }
  //   } catch (e) {
  //     print('Error fetching hotel details: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Get hotel by ID
  Future<void> getHotelById(String hotelId) async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

      // Find hotel in the list
      final foundHotel = hotelsList.firstWhere(
            (h) => h.id == hotelId,
        orElse: () => Hotel.empty(),
      );

      if (foundHotel.id.isNotEmpty) {
        hotel.value = foundHotel;
      } else {
        throw Exception('Hotel not found with ID: $hotelId');
      }
    } catch (e) {
      print('Error fetching hotel by ID: $e');
      hotel.value = Hotel.empty();
      Get.snackbar(
        'Error',
        'Could not find hotel with ID: $hotelId',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}