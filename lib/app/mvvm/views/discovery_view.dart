import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../configs/app_colors.dart';
import '../../configs/app_routes.dart';
import '../view_models/discovery_view_controller.dart';

class DiscoveryView extends StatefulWidget {
  const DiscoveryView({super.key});

  @override
  State<DiscoveryView> createState() => _DiscoveryViewState();
}

class _DiscoveryViewState extends State<DiscoveryView> {
  final DiscoveryController controller = Get.find<DiscoveryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withOpacity(0.15),
                  Colors.white,
                ],
              ),
            ),
          ),
          // Main Content
          SafeArea(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: FadeIn(
                    duration: Duration(milliseconds: 800),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildSearchBar(),
                    _buildSavedTripsSection(),
                    _buildRecommendationsSection(),
                    SizedBox(height: 80.h), // Space for FAB
                  ],
                ),
              );
            }),
          ),
          // Floating Action Button
          Positioned(
            bottom: 20.h,
            right: 20.w,
            child: Jello(
              duration: const Duration(milliseconds: 1000),
              child: FloatingActionButton(
                onPressed: () => Get.snackbar(
                  'Map',
                  'Full map view coming soon!',
                  backgroundColor: AppColors.primary.withOpacity(0.9),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                ),
                backgroundColor: AppColors.primary,
                mini: true,
                child: const Icon(Icons.map, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
      child: CachedNetworkImage(
        imageUrl: 'https://images.unsplash.com/photo-1503220317375-aaad61436b1b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[300],
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[300],
          child: const Icon(Icons.error),
        ),
        imageBuilder: (context, imageProvider) => Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.9),
                BlendMode.dstATop,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                blurRadius: 20.r,
                offset: Offset(0, 10.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BounceInDown(
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  'Next Escape',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2.r,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: Row(
                  children: [
                    Icon(Icons.location_pin, color: AppColors.primary, size: 22.sp),
                    SizedBox(width: 10.w),
                    Text(
                      'In ${controller.currentLocation}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 2.r,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSearchBar() {
    return BounceInUp(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 200),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 15.r,
              offset: Offset(0, 5.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.primary, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Where to?',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            ZoomIn(
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.tune, color: AppColors.primary, size: 20.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedTripsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlipInX(
            duration: const Duration(milliseconds: 700),
            child: Text(
              'Saved Trips',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          controller.savedTrips.isEmpty
              ? FadeInUp(
            child: Text(
              'No saved trips yet',
              style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
            ),
          )
              : SizedBox(
            height: 200.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.savedTrips.length,
              itemBuilder: (context, index) {
                final trip = controller.savedTrips[index];
                return FadeInRight(
                  duration: const Duration(milliseconds: 800),
                  delay: Duration(milliseconds: index * 200),
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.tripDetails, arguments: {'tripId': trip.id}),
                    child: Container(
                      width: 160.w,
                      margin: EdgeInsets.only(right: 15.w),
                      child: Stack(
                        alignment: Alignment.topCenter, // Align stack content better
                        children: [
                          Positioned(
                            top: 40.h, // Adjusted for better alignment
                            child: Container(
                              height: 160.h,
                              width: 160.w,
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.1),
                                    blurRadius: 12.r,
                                    offset: Offset(0, 6.h),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    trip.name,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      Icon(Icons.event, size: 14.sp, color: AppColors.primary),
                                      SizedBox(width: 6.w),
                                      Expanded(
                                        child: Text(
                                          '${trip.startDate}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey[700],
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Wrap(
                                    spacing: 8.w,
                                    runSpacing: 6.h,
                                    children: trip.destinations
                                        .take(2)
                                        .map(
                                          (dest) => Chip(
                                        label: Text(
                                          dest,
                                          style: TextStyle(fontSize: 10.sp, color: AppColors.primary),
                                        ),
                                        backgroundColor: AppColors.primary.withOpacity(0.1),
                                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0, // Adjusted to prevent overflow
                            child: Hero(
                              tag: 'tripImage_${trip.id}',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: CachedNetworkImage(
                                  imageUrl: trip.imageUrl,
                                  height: 100.h, // Reduced to fit better
                                  width: 140.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    height: 100.h,
                                    width: 140.w,
                                    color: Colors.grey[300],
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    height: 100.h,
                                    width: 140.w,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.error, size: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }

  Widget _buildRecommendationsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlipInX(
            duration: const Duration(milliseconds: 700),
            child: Text(
              'For You',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          controller.recommendations.isEmpty
              ? FadeInUp(
            child: Text(
              'No recommendations',
              style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
            ),
          )
              : SizedBox(
            height: 240.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.recommendations.length,
              itemBuilder: (context, index) {
                final trip = controller.recommendations[index];
                return FadeInRight(
                  duration: const Duration(milliseconds: 800),
                  delay: Duration(milliseconds: index * 150),
                  child: GestureDetector(
                    onTap: () => Get.toNamed('/tripDetails', arguments: {'tripId': trip.id}),
                    child: Container(
                      width: 150.w,
                      margin: EdgeInsets.only(right: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: 'tripImage_${trip.id}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: trip.imageUrl,
                                    height: 180.h,
                                    width: 150.w,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      height: 180.h,
                                      width: 150.w,
                                      color: Colors.grey[300],
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      height: 180.h,
                                      width: 150.w,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.error),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10.h,
                                    right: 10.w,
                                    child: ZoomIn(
                                      child: Container(
                                        padding: EdgeInsets.all(6.w),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.9),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 6.r,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.favorite_border,
                                          size: 18.sp,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(10.w),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.7),
                                          ],
                                        ),
                                      ),
                                      child: Text(
                                        trip.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          shadows: [Shadow(color: Colors.black45, blurRadius: 2.r)],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Icon(Icons.map, size: 14.sp, color: AppColors.primary),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  trip.destinations.join(', '),
                                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[800]),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }
}