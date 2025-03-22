import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../configs/app_colors.dart';
import '../view_models/discovery_view_controller.dart';

class TripDetailsPage extends StatelessWidget {
  const TripDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoveryController controller = Get.find<DiscoveryController>();
    final String? tripId = Get.arguments?['tripId'] as String?;
    final trip = controller.getTripById(tripId ?? '');

    if (trip == null) {
      return Scaffold(
        body: Center(child: Text('Trip not found', style: TextStyle(fontSize: 16.sp))),
      );
    }

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
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200.h,
                floating: false,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.transparent,
                leading: FadeInLeft(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'tripImage_${trip.id}',
                        child: CachedNetworkImage(
                          imageUrl: trip.imageUrl,
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.3),
                          colorBlendMode: BlendMode.darken,
                        ),
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
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BounceInDown(
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          trip.name,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      FadeInUp(
                        duration: const Duration(milliseconds: 800),
                        child: Row(
                          children: [
                            Icon(Icons.event, size: 16.sp, color: AppColors.primary),
                            SizedBox(width: 8.w),
                            Text(
                              '${trip.startDate} - ${trip.endDate}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: Text(
                          'Destinations',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 6.h,
                        children: trip.destinations.map((dest) => Chip(
                          label: Text(
                            dest,
                            style: TextStyle(fontSize: 12.sp, color: AppColors.primary),
                          ),
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        )).toList(),
                      ),
                      SizedBox(height: 20.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: Container(
                          height: 150.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Center(
                            child: Text(
                              'Map Placeholder\n(To be implemented)',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ZoomIn(
                        delay: const Duration(milliseconds: 600),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.snackbar('Book', 'Booking feature coming soon!',
                                backgroundColor: AppColors.primary, colorText: Colors.white);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                          ),
                          child: Text(
                            'Book Now',
                            style: TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}