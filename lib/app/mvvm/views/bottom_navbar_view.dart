import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:mvp/app/configs/extenstions.dart';
import '../../configs/app_colors.dart';
import '../view_models/bottom_navbar_controller.dart';


class BottomNavBarView extends StatelessWidget {
  BottomNavBarView({super.key});

  final BottomSheetController controller = Get.find<BottomSheetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: controller.pages,
      ),
      bottomNavigationBar: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [Colors.white, AppColors.primary, Colors.white],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem("Explore", Icons.explore, Icons.explore, 0),
              _buildNavItem("Hotels", Icons.hotel, Icons.hotel, 1),
              5.w.width,
              GestureDetector(
                onTap: () => controller.changePage(2),
                child: Container(
                  height: 43.h,
                  width: 66.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
              ),
              5.w.width,
              _buildNavItem("Food", Icons.restaurant, Icons.restaurant, 3),
              _buildNavItem("Profile", Icons.person, Icons.person, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, IconData icon, IconData activeIcon, int index) {
    return Obx(() => CustomBottomBarItem(
      title: title,
      icon: icon,
      activeIcon: activeIcon,
      selected: controller.currentIndex.value == index,
      onTap: () => controller.changePage(index),
    ));
  }
}

class CustomBottomBarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final IconData activeIcon;
  final bool selected;
  final VoidCallback onTap;

  const CustomBottomBarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.activeIcon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? activeIcon : icon,
              size: 24.sp,
              color: selected ? Colors.black : Colors.grey,
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: selected ? Colors.black : const Color(0xFF94A3B8),
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}