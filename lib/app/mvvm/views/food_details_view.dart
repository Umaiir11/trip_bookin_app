import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mvp/app/mvvm/view_models/food_controller.dart';
import '../../configs/app_colors.dart';
import '../models/dto/food_model.dart';
import '../models/dto/hotel_model.dart';
import '../view_models/hotel_view_controller.dart';

class FoodDetailsView extends StatefulWidget {
  const FoodDetailsView({super.key});

  @override
  State<FoodDetailsView> createState() => _FoodDetailsViewState();
}

class _FoodDetailsViewState extends State<FoodDetailsView> {
  final FoodController controller = Get.find<FoodController>();

  @override
  void initState() {
    super.initState();
    final hotelId = Get.arguments?['hotelId'] as String?;
    if (hotelId != null) {
      controller.getFoodById(hotelId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final hotel = controller.food.value;
          if (hotel.id.isEmpty) {
            return const Center(child: Text('Hotel not found'));
          }

          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(hotel),
              SliverToBoxAdapter(child: _buildGallery(hotel)),
              SliverToBoxAdapter(child: _buildHotelInfo(hotel)),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSliverAppBar(Food hotel) {
    return SliverAppBar(
      expandedHeight: 320.h,
      floating: false,
      pinned: true,
      backgroundColor: Colors.black,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          margin: EdgeInsets.all(10.w),
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Icon(Icons.arrow_back_ios_new, color: AppColors.primary, size: 20.sp),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => controller.toggleFavorite(),
          child: Container(
            margin: EdgeInsets.all(10.w),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Obx(() => Icon(
              controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
              color: controller.isFavorite.value ? Colors.red : AppColors.primary,
              size: 20.sp,
            )),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 15.w, bottom: 15.h), // Pushes title to bottom left
        title: Align(
          alignment: Alignment.bottomLeft, // Aligns to bottom left corner
          child: Text(
            hotel.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              shadows: [Shadow(color: Colors.black45, blurRadius: 4.r)],
            ),
            textAlign: TextAlign.left, // Ensures text aligns left within its box
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'hotelImage_${hotel.id}',
              child: CachedNetworkImage(
                imageUrl: hotel.images[0],
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.grey[300]),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildGallery(Food hotel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gallery',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 220.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hotel.images.length + hotel.videoUrls.length,
              itemBuilder: (context, index) {
                if (index < hotel.images.length) {
                  // Image item
                  return FadeInRight(
                    duration: Duration(milliseconds: 400 * (index + 1)),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: CachedNetworkImage(
                          imageUrl: hotel.images[index],
                          width: 250.w,
                          height: 220.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 250.w,
                            height: 220.h,
                            color: Colors.grey[300],
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 250.w,
                            height: 220.h,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error, size: 20),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  // Video placeholder item
                  final videoIndex = index - hotel.images.length;
                  return FadeInRight(
                    duration: Duration(milliseconds: 400 * (index + 1)),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: GestureDetector(
                        onTap: () {
                          Get.snackbar('Video', 'Video playback coming soon: ${hotel.videoUrls[videoIndex]}');
                        },
                        child: Container(
                          width: 250.w,
                          height: 220.h,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: hotel.images[0], // Thumbnail (could use video thumbnail API)
                                width: 250.w,
                                height: 220.h,
                                fit: BoxFit.cover,
                                color: Colors.black.withOpacity(0.5),
                                colorBlendMode: BlendMode.darken,
                              ),
                              Center(
                                child: Icon(
                                  Icons.play_circle_outline,
                                  color: Colors.white,
                                  size: 50.sp,
                                ),
                              ),
                              Positioned(
                                bottom: 10.h,
                                left: 10.w,
                                child: Text(
                                  'Video ${videoIndex + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelInfo(Food hotel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  hotel.cuisine,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16.sp),
                    SizedBox(width: 5.w),
                    Text(
                      '${hotel.rating}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            'Ingredients',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: hotel.ingredients.map((amenity) => _buildAmenityChip(amenity)).toList(),
          ),
          SizedBox(height: 20.h),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            hotel.description,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${hotel.price}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'per night',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Get.snackbar('Booking', 'Booking feature coming soon!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityChip(String amenity) {
    return Chip(
      label: Text(
        amenity,
        style: TextStyle(fontSize: 12.sp, color: AppColors.primary),
      ),
      backgroundColor: AppColors.primary.withOpacity(0.1),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    );
  }
}