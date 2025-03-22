import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../configs/app_colors.dart';
import '../../configs/app_routes.dart';
import '../models/dto/food_model.dart';
import '../models/dto/hotel_model.dart';
import '../view_models/food_controller.dart';
import '../view_models/hotel_view_controller.dart';

class FoodsView extends StatefulWidget {
  const FoodsView({super.key});

  @override
  State<FoodsView> createState() => _FoodsViewState();
}

class _FoodsViewState extends State<FoodsView> with SingleTickerProviderStateMixin {
  final FoodController controller = Get.find();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
            child: Column(
              children: [
                // TabBar Header
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      controller: _tabController,
                      labelColor: AppColors.accent,
                      unselectedLabelColor: AppColors.black,
                      labelStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      indicatorColor: AppColors.accent,
                      indicatorWeight: 3.h,
                      tabs: const [
                        Tab(text: 'TOP RATED'),
                        Tab(text: 'NEARBY'),
                        Tab(text: 'CHEAP'),
                      ],
                    ),
                  ],
                ),              // TabBarView with Filtered Grid
                Expanded(
                  child: Obx(() {
                    List<Food> filteredHotels = controller.foodsList;
                    return MasonryGridView.count(
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.h,
                      crossAxisSpacing: 15.w,
                      itemCount: filteredHotels.length,
                      itemBuilder: (context, index) {
                        final hotel = filteredHotels[index];
                        return FadeInUp(
                          duration: Duration(milliseconds: 400 * (index + 1)),
                          child: FoodlTile(
                            hotel: hotel,
                            onTap: () {
                              Get.toNamed(
                                Routes.food,
                                arguments: {'hotelId': hotel.id},
                              );
                            },
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

class FoodlTile extends StatelessWidget {
  final Food hotel;
  final VoidCallback onTap;

  const FoodlTile({
    super.key,
    required this.hotel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'hotelImage_${hotel.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                child: CachedNetworkImage(
                  imageUrl: hotel.images[0],
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 180.h,
                    color: Colors.grey[300],
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 180.h,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error, size: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
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
                      Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 14.sp,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          hotel.cuisine,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[700],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${hotel.price}/night',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      ZoomIn(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 12.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${hotel.rating}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
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
            ),
          ],
        ),
      ),
    );
  }
}