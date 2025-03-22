import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../configs/app_colors.dart';
import '../view_models/trip_selection_view_model.dart';

class ItineraryDisplayScreen extends StatelessWidget {
  const ItineraryDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TripController controller = Get.find<TripController>();

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          CachedNetworkImage(
            imageUrl: 'https://plus.unsplash.com/premium_photo-1677343210638-5d3ce6ddbf85?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace with your image URL
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            placeholder: (context, url) => Container(color: Colors.grey[300]),
            errorWidget: (context, url, error) => Container(color: Colors.grey[300], child: const Icon(Icons.error)),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Custom Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FadeInDown(
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          'Your Itinerary',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(color: AppColors.primary.withOpacity(0.5), blurRadius: 5.r),
                            ],
                          ),
                        ),
                      ),
                      ZoomIn(
                        duration: const Duration(milliseconds: 1000),
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.white, size: 28.sp),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                ),
                // Itinerary List
                Expanded(
                  child: Obx(() {
                    final trip = controller.generatedTrip.value;
                    if (trip == null) {
                      return Center(
                        child: ElasticIn(
                          duration: const Duration(milliseconds: 1200),
                          child: Text(
                            'No itinerary generated',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      itemCount: trip.itinerary.length,
                      itemBuilder: (context, index) {
                        final dayPlan = trip.itinerary[index];
                        return SlideInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: Duration(milliseconds: index * 200),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15.h),
                            padding: EdgeInsets.all(15.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2), // Glassmorphism effect
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.2),
                                  blurRadius: 10.r,
                                  offset: Offset(0, 5.h),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dayPlan.day,
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                ...dayPlan.activities.map(
                                      (activity) => Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppColors.primary,
                                          size: 20.sp,
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Text(
                                            activity,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}