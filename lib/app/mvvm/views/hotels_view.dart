import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mvp/app/configs/app_pages.dart';
import '../../configs/app_routes.dart';
import '../models/dto/hotel_model.dart';
import '../view_models/dto_class.dart';
import '../view_models/hotel_view_controller.dart';
import 'hotel_view.dart'; // Import the HotelView file

class HotelsView extends StatefulWidget {
  const HotelsView({super.key});

  @override
  State<HotelsView> createState() => _HotelsViewState();
}

class _HotelsViewState extends State<HotelsView> {
  final HotelController controller = Get.put(HotelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotels'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(() => ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          itemCount: controller.hotelsList.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              duration: Duration(milliseconds: 300 * (index + 1)),
              child: HotelTile(
                hotel: controller.hotelsList[index],
                onTap: () {
                  Get.toNamed(
                    Routes.hotel,
                    arguments: {'hotelId': controller.hotelsList[index].id},
                  );
                },
              ),
            );
          },
        )),
      ),
    );
  }
}
class HotelTile extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback onTap;

  const HotelTile({
    super.key,
    required this.hotel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              // Hotel Image
              Image.network(
                hotel.images[0],
                height: 180.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Gradient overlay
              Container(
                height: 180.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              // Hotel Info
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel.name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white70,
                            size: 14.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            hotel.location,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${hotel.price}/night',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '${hotel.rating}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

