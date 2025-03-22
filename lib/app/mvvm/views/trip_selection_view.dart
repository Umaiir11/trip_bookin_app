import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../configs/app_colors.dart';
import '../view_models/trip_selection_view_model.dart';

class TripSelectionView extends StatelessWidget {
  const TripSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final TripController controller = Get.put(TripController());

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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: Text(
                      'Plan Your Escape',
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
                  SizedBox(height: 30.h),
                  _buildDurationSelector(controller),
                  SizedBox(height: 25.h),
                  _buildPreferencesSelector(controller),
                  SizedBox(height: 40.h),
                  _buildGenerateButton(controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSelector(TripController controller) {
    return BounceInUp(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trip Duration',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [1, 2, 3].map((days) {
              return Obx(
                    () => GestureDetector(
                  onTap: () => controller.selectedDuration.value = days,
                  child: ElasticIn(
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      decoration: BoxDecoration(
                        color: controller.selectedDuration.value == days
                            ? AppColors.primary.withOpacity(0.9)
                            : Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.2),
                            blurRadius: 10.r,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$days Day${days > 1 ? 's' : ''}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSelector(TripController controller) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Preferences',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          SizedBox(height: 15.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: controller.availablePreferences.map(
                  (pref) => Obx(
                    () => GestureDetector(
                  onTap: () => controller.togglePreference(pref),
                  child: SlideInRight(
                    duration: const Duration(milliseconds: 600),
                    delay: Duration(milliseconds: controller.availablePreferences.indexOf(pref) * 100),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: controller.selectedPreferences.contains(pref)
                            ? AppColors.primary.withOpacity(0.9)
                            : Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25.r),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.1),
                            blurRadius: 8.r,
                          ),
                        ],
                      ),
                      child: Text(
                        pref,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton(TripController controller) {
    return ZoomIn(
      duration: const Duration(milliseconds: 1000),
      child: GestureDetector(
        onTap: controller.generateItinerary,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 50.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(40.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.5),
                blurRadius: 15.r,
                offset: Offset(0, 5.h),
              ),
            ],
          ),
          child: Text(
            'Generate Your Itinerary',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    );
  }
}