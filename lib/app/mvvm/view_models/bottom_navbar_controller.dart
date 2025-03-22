import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvp/app/mvvm/views/trip_selection_view.dart';

import '../views/discovery_view.dart';
import '../views/foods_view.dart';
import '../views/hotel_view.dart';
import '../views/hotels_view.dart';
import '../views/search_view.dart';

class BottomSheetController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  final List<Widget> pages = [
    const DiscoveryView(),
    const HotelsView(),
    const SearchView(),
    const FoodsView(),
    const TripSelectionView(),
  ];

  void changePage(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
      pageController.jumpToPage(index);
    }
  }
}