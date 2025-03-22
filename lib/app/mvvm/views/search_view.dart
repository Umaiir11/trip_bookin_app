import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../configs/app_colors.dart';
import '../view_models/discovery_view_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final DiscoveryController controller = Get.find<DiscoveryController>();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with Cached Image
          CachedNetworkImage(
            imageUrl: 'https://plus.unsplash.com/premium_photo-1677343210638-5d3ce6ddbf85?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace with your image URL
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            placeholder: (context, url) => Container(color: Colors.grey[300]),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.error),
            ),
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
                _buildHeader(),
                SizedBox(height: 30.h),
                _buildSearchBar(),
                SizedBox(height: 20.h),
                Expanded(child: _buildSearchResults()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      duration: const Duration(milliseconds: 800),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElasticIn(
              duration: const Duration(milliseconds: 1000),
              child: Text(
                'Search Your Escape',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      color: AppColors.primary.withOpacity(0.5),
                      blurRadius: 5.r,
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
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(40.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 15.r,
              offset: Offset(0, 5.h),
            ),
          ],
          border: _isSearchFocused
              ? Border.all(color: AppColors.primary, width: 2.w)
              : null,
        ),
        child: Row(
          children: [
            Spin(
              duration: const Duration(milliseconds: 1000),
              child: Icon(Icons.search, color: AppColors.primary, size: 26.sp),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Where are you escaping to?',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                onTap: () => setState(() => _isSearchFocused = true),
                onSubmitted: (_) => setState(() => _isSearchFocused = false),
                onChanged: (value) {
                  // Add search logic here if needed
                },
              ),
            ),
            if (_searchController.text.isNotEmpty)
              ZoomIn(
                child: IconButton(
                  icon: Icon(Icons.clear, color: AppColors.primary, size: 20.sp),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                ),
              )
            else
              Jello(
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.tune, color: AppColors.primary, size: 22.sp),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    // Placeholder for search results; replace with actual logic
    final bool hasResults = _searchController.text.isNotEmpty;
    return hasResults
        ? ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      itemCount: 5, // Replace with actual results count
      itemBuilder: (context, index) {
        return FadeInUp(
          duration: const Duration(milliseconds: 600),
          delay: Duration(milliseconds: index * 100),
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 10.r,
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: CachedNetworkImage(
                    imageUrl: 'https://example.com/result-$index.jpg', // Replace with real URL
                    height: 60.h,
                    width: 60.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey[300]),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Destination $index',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'Location $index',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 18.sp),
              ],
            ),
          ),
        );
      },
    )
        : Center(
      child: ElasticIn(
        duration: const Duration(milliseconds: 1200),
        child: Text(
          'Start typing to search...',
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}