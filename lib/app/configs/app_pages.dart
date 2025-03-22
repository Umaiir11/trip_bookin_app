import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mvp/app/mvvm/view_models/bottom_navbar_controller.dart';
import 'package:mvp/app/mvvm/views/food_details_view.dart';
import 'package:mvp/app/mvvm/views/tips_details.dart';

import '../../main.dart';
import '../mvvm/view_models/discovery_view_controller.dart';
import '../mvvm/view_models/food_controller.dart';
import '../mvvm/view_models/hotel_view_controller.dart';
import '../mvvm/view_models/trip_selection_view_model.dart';
import '../mvvm/views/bottom_navbar_view.dart';
import '../mvvm/views/discovery_view.dart';
import '../mvvm/views/hotel_view.dart';
import '../mvvm/views/itinerary_display_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.main;

  static final routes = [
    GetPage(
      name: Routes.main,
      page: () =>  BottomNavBarView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DiscoveryController>(() => DiscoveryController());
        Get.lazyPut<HotelController>(() => HotelController());
        Get.lazyPut<FoodController>(() => FoodController());
        Get.lazyPut<BottomSheetController>(
          () => BottomSheetController(),
        );
      }),
    ),
    GetPage(
      name: Routes.discovery,
      page: () => const DiscoveryView(),
      // binding: DiscoveryBinding(),
    ), GetPage(
      name: Routes.tripDetails,
      page: () => const TripDetailsPage(),
      // binding: DiscoveryBinding(),
    ),
    GetPage(
      name: Routes.hotel,
      page: () => const HotelView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HotelController>(() => HotelController());

      }),
    ),
    GetPage(
      name: Routes.food,
      page: () => const FoodDetailsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HotelController>(() => HotelController());

      }),
    ),GetPage(
      name: Routes.itineraryDisplay,
      page: () => const ItineraryDisplayScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<TripController>(() => TripController());

      }),
    ),
  ];
}
