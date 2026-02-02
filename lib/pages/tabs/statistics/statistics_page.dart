import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_ai_pocket/core/theme/theme_helper.dart';
import 'statistics_controller.dart';
import 'statistics_state.dart';

/// 统计页面
class StatisticsPage extends GetView<StatisticsController> {
  const StatisticsPage({super.key});

  @override
  StatisticsController get controller => Get.find<StatisticsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('statistics'.tr)),
      body: Column(
        children: [
          // 顶部：白底统计图占位
          _buildChartPlaceholder(),
          // 底部：主题色背景按月统计
          Expanded(
            child: _buildMonthlyStatistics(),
          ),
        ],
      ),
    );
  }

  /// 构建统计图占位
  Widget _buildChartPlaceholder() {
    return Container(
      width: double.infinity,
      height: 200.h,
      color: ThemeHelper.cardColor,
      child: Center(
        child: Text(
          '统计图占位',
          style: TextStyle(
            fontSize: 16.sp,
            color: ThemeHelper.textSecondaryColor,
          ),
        ),
      ),
    );
  }

  /// 构建按月统计列表
  Widget _buildMonthlyStatistics() {
    return Container(
      color: ThemeHelper.primaryColor,
      child: Column(
        children: [
          // Tab 切换
          _buildTypeTabs(),
          // 统计列表
          Expanded(
            child: Obx(() {
              if (controller.state.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              }
              
              if (controller.state.monthlyStats.isEmpty) {
                return Center(
                  child: Text(
                    '暂无统计数据',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                );
              }
              
              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: controller.state.monthlyStats.length,
                itemBuilder: (context, index) {
                  final stats = controller.state.monthlyStats[index];
                  return _buildMonthlyStatItem(stats);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  /// 构建类型切换 Tab
  Widget _buildTypeTabs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          _buildTabItem(0, 'expense'.tr),
          _buildTabItem(1, 'income'.tr),
          _buildTabItem(2, 'total'.tr),
        ],
      ),
    );
  }

  /// 构建单个 Tab 项
  Widget _buildTabItem(int type, String label) {
    return Obx(() {
      final isSelected = controller.state.selectedType.value == type;
      return Expanded(
        child: GestureDetector(
          onTap: () => controller.switchType(type),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? ThemeHelper.primaryColor
                    : Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ),
      );
    });
  }

  /// 构建月度统计项
  Widget _buildMonthlyStatItem(MonthlyStatistics stats) {
    final amount = controller.getCurrentAmount(stats);
    final absAmount = amount.abs();
    final amountStr = controller.formatAmount(absAmount);
    final prefix = amount < 0 ? '-' : '';
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            stats.displayYearMonth,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            '$prefix¥$amountStr',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
