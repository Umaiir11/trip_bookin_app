import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../configs/app_colors.dart';
import '../../configs/app_routes.dart';
import '../view_models/discovery_view_controller.dart';

class DiscoveryView extends StatefulWidget {
  const DiscoveryView({super.key});

  @override
  State<DiscoveryView> createState() => _DiscoveryViewState();
}

class _DiscoveryViewState extends State<DiscoveryView> with TickerProviderStateMixin {
  final DiscoveryController controller = Get.find<DiscoveryController>();

  @override
  void dispose() {
    // Ensure any custom tickers or controllers are disposed here if added later
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          SafeArea(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: FadeIn( // Replaced Swing to avoid ticker issues
                    duration: const Duration(milliseconds: 800),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  _buildSliverAppBar(),
                  SliverToBoxAdapter(child: _buildSearchBar()),
                  SliverToBoxAdapter(child: _buildSavedTripsSection()),
                  SliverToBoxAdapter(child: _buildRecommendationsSection()),
                  SliverToBoxAdapter(child: SizedBox(height: 60.h)),
                ],
              );
            }),
          ),
          Positioned(
            bottom: 15.h,
            right: 15.w,
            child: Jello(
              duration: const Duration(milliseconds: 1000),
              child: FloatingActionButton(
                onPressed: () {
                  Get.snackbar('Map', 'Full map view coming soon!',
                      backgroundColor: AppColors.primary.withOpacity(0.9),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP);
                },
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

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 160.h,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: 'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              top: 30.h,
              left: 15.w,
              child: FlipInX(
                duration: const Duration(milliseconds: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FadeIn( // Replaced Swing
                          duration: const Duration(milliseconds: 1000),
                          child: const Icon(Icons.location_pin, color: Colors.white, size: 18),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'In ${controller.currentLocation}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    BounceInDown(
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        'Next Escape',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
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
  }

  Widget _buildSearchBar() {
    return BounceInUp(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 200),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.primary, size: 20),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Where to?',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            ZoomIn(
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.tune, color: AppColors.primary, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedTripsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: FlipInX(
            duration: const Duration(milliseconds: 700),
            child: Text(
              'Saved Trips',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        controller.savedTrips.isEmpty
            ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: FadeInUp(
            child: Text(
              'No saved trips yet',
              style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
            ),
          ),
        )
            : SizedBox(
          height: 190.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            itemCount: controller.savedTrips.length,
            itemBuilder: (context, index) {
              final trip = controller.savedTrips[index];
              return FadeInRight(
                duration: const Duration(milliseconds: 800),
                delay: Duration(milliseconds: index * 200),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.tripDetails, arguments: {'tripId': trip.id});
                  },
                  child: Container(
                    width: 160.w,
                    margin: EdgeInsets.only(right: 12.w),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 25.h,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 160.h,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
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
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Icon(Icons.event, size: 12.sp, color: AppColors.primary),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      child: Text(
                                        '${trip.startDate}',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.grey[700],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Wrap(
                                  spacing: 6.w,
                                  runSpacing: 4.h,
                                  children: trip.destinations.take(2).map((dest) => Chip(
                                    label: Text(
                                      dest,
                                      style: TextStyle(fontSize: 8.sp, color: AppColors.primary),
                                    ),
                                    backgroundColor: AppColors.primary.withOpacity(0.1),
                                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  )).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -15.h,
                          left: 15.w,
                          child: Hero(
                            tag: 'tripImage_${trip.id}', // Unique tag for Hero animation
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: CachedNetworkImage(
                                imageUrl: trip.imageUrl,
                                height: 100.h,
                                width: 130.w,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  height: 100.h,
                                  width: 130.w,
                                  color: Colors.grey[300],
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 100.h,
                                  width: 130.w,
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
      ],
    );
  }
  Widget _buildRecommendationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: FlipInX(
            duration: const Duration(milliseconds: 700),
            child: Text(
              'For You',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        controller.recommendations.isEmpty
            ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: FadeInUp(
            child: Text(
              'No recommendations',
              style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
            ),
          ),
        )
            : SizedBox(
          height: 220.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            itemCount: controller.recommendations.length,
            itemBuilder: (context, index) {
              final trip = controller.recommendations[index];
              return FadeInRight(
                duration: const Duration(milliseconds: 800),
                delay: Duration(milliseconds: index * 150),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/tripDetails', arguments: {'tripId': trip.id});
                  },
                  child: Container(
                    width: 140.w,
                    margin: EdgeInsets.only(right: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'tripImage_${trip.id}', // Unique tag matching TripDetailsPage
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: trip.imageUrl,
                                  height: 160.h,
                                  width: 140.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    height: 160.h,
                                    width: 140.w,
                                    color: Colors.grey[300],
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    height: 160.h,
                                    width: 140.w,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.error),
                                  ),
                                ),
                                Positioned(
                                  top: 8.h,
                                  right: 8.w,
                                  child: ZoomIn(
                                    child: Container(
                                      padding: EdgeInsets.all(4.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(Icons.favorite_border,
                                          size: 16, color: AppColors.primary),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.7)
                                        ],
                                      ),
                                    ),
                                    child: Text(
                                      trip.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(color: Colors.black45, blurRadius: 2)
                                        ],
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
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            FadeIn(
                              child: Icon(Icons.map, size: 12.sp, color: AppColors.primary),
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Text(
                                trip.destinations.join(', '),
                                style: TextStyle(fontSize: 10.sp, color: Colors.grey[800]),
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
      ],
    );
  }}