import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/dto/trip_model.dart';
import 'dto_class.dart';

class DiscoveryController extends GetxController {
  final RxList<Trip> savedTrips = <Trip>[].obs;
  final RxList<Trip> recommendations = <Trip>[].obs;
  final RxBool isLoading = true.obs;
  final RxString currentLocation = "US".obs;
  final RxList<Trip> allTrips = <Trip>[].obs; // Store all trips

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 800)); // Simulate network delay
      // Initialize all trips
      allTrips.value = _getAllTrips();

      // Assign trips to respective lists based on properties
      savedTrips.value = allTrips.where((trip) => trip.isSaved).toList();
      recommendations.value = allTrips.where((trip) => trip.isRecommendation).toList();
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to get trip by ID
  Trip? getTripById(String id) {
    try {
      return allTrips.firstWhere((trip) => trip.id == id);
    } catch (e) {
      print('Trip not found with ID: $id');
      return null;
    }
  }

  // Private method to generate 10 trips
  List<Trip> _getAllTrips() {
    return [
      // 7 Trips with isRecommendation = true and isSaved = false
      Trip(
        id: '1',
        name: 'Summer in Greece',
        imageUrl: 'https://images.unsplash.com/photo-1533105079780-92b9be482077',
        startDate: 'Jun 15',
        endDate: 'Jul 1',
        destinations: ['Santorini', 'Athens', 'Mykonos'],
        isRecommendation: true,
        isSaved: false,
      ),
      Trip(
        id: '2',
        name: 'Asian Adventure',
        imageUrl: 'https://images.unsplash.com/photo-1528164344705-47542687000d',
        startDate: 'Aug 10',
        endDate: 'Aug 30',
        destinations: ['Tokyo', 'Seoul', 'Bangkok'],
        isRecommendation: true,
        isSaved: false,
      ),
      Trip(
        id: '3',
        name: 'Oia Santorini',
        imageUrl: 'https://images.unsplash.com/photo-1533105079780-92b9be482077',
        startDate: 'Sep 5',
        endDate: 'Sep 15',
        destinations: ['Santorini'],
        isRecommendation: true,
        isSaved: false,
      ),
      Trip(
        id: '4',
        name: 'Jeju Island',
        imageUrl: 'https://images.unsplash.com/photo-1527824404775-dce343118ebc',
        startDate: 'Oct 10',
        endDate: 'Oct 20',
        destinations: ['Jeju'],
        isRecommendation: true,
        isSaved: false,
      ),
      Trip(
        id: '5',
        name: 'Hoi An',
        imageUrl: 'https://images.unsplash.com/photo-1528127269322-539801943592',
        startDate: 'Nov 15',
        endDate: 'Nov 25',
        destinations: ['Hoi An'],
        isRecommendation: true,
        isSaved: false,
      ),
      Trip(
        id: '6',
        name: 'Paris Getaway',
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
        startDate: 'Dec 1',
        endDate: 'Dec 7',
        destinations: ['Paris'],
        isRecommendation: true,
        isSaved: false,
      ),
      Trip(
        id: '7',
        name: 'New York City Break',
        imageUrl: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62bf4e',
        startDate: 'Jan 10',
        endDate: 'Jan 15',
        destinations: ['New York'],
        isRecommendation: true,
        isSaved: false,
      ),

      // 2 Trips with isRecommendation = false and isSaved = true
      Trip(
        id: '8',
        name: 'London Exploration',
        imageUrl: 'https://images.unsplash.com/photo-1505761671935-60b3a7427bad',
        startDate: 'Feb 5',
        endDate: 'Feb 12',
        destinations: ['London'],
        isRecommendation: false,
        isSaved: true,
      ),
      Trip(
        id: '9',
        name: 'Barcelona Weekend',
        imageUrl: 'https://images.unsplash.com/photo-1543783207-ec64e4d95325',
        startDate: 'Mar 20',
        endDate: 'Mar 25',
        destinations: ['Barcelona'],
        isRecommendation: false,
        isSaved: true,
      ),

      // 1 Additional Trip with isRecommendation = false and isSaved = false
      Trip(
        id: '10',
        name: 'Amsterdam Journey',
        imageUrl: 'https://images.unsplash.com/photo-1512470876302-972faa2aa9a4',
        startDate: 'Apr 15',
        endDate: 'Apr 20',
        destinations: ['Amsterdam'],
        isRecommendation: false,
        isSaved: false,
      ),
    ];
  }
}

