import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_ai_pocket/core/theme/theme_helper.dart';
import 'package:my_ai_pocket/core/utils/icon_helper.dart';
import 'package:my_ai_pocket/core/database/app_database.dart';
import 'home_controller.dart';

/// 首页
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  HomeController get controller => Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('accountBook'.tr)),
      body: Stack(
        children: [
          Obx(() {
            if (controller.state.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (controller.state.bills.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 64,
                      color: ThemeHelper.textTertiaryColor,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'noBills'.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ThemeHelper.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return RefreshIndicator(
              onRefresh: controller.loadBills,
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: controller.state.bills.length,
                itemBuilder: (context, index) {
                  final bill = controller.state.bills[index];
                  return _buildBillCard(bill, index == controller.state.bills.length - 1);
                },
              ),
            );
          }),
          // 固定右下角 Add 按钮（最稳定写法）
          Positioned(
            right: 16.w,
            bottom: 24.h,
            child: FloatingActionButton(
              backgroundColor: ThemeHelper.primaryColor,
              onPressed: () {
                controller.addBillEvent();
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建账单卡片
  Widget _buildBillCard(BillTableData bill, bool isLast) {
    final category = controller.getCategory(bill.categoryId);
    final isExpense = bill.type == 0;
    final amount = controller.formatAmount(bill.amountMinor);
    final time = controller.formatTime(bill.occurredAt);
    
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
      decoration: BoxDecoration(
        color: ThemeHelper.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // 可以添加点击事件，比如查看详情或编辑
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // 分类图标
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: category != null
                        ? IconHelper.hexToColor(category.color).withOpacity(0.1)
                        : ThemeHelper.dividerColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    category != null
                        ? IconHelper.getIconData(category.iconName)
                        : Icons.category,
                    color: category != null
                        ? IconHelper.hexToColor(category.color)
                        : ThemeHelper.textSecondaryColor,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                // 分类名称和备注
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category != null ? category.name.tr : 'unknownCategory'.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeHelper.textPrimaryColor,
                        ),
                      ),
                      if (bill.note != null && bill.note!.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          bill.note!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ThemeHelper.textSecondaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                // 金额和时间
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isExpense ? '-' : '+'}¥$amount',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: isExpense
                            ? ThemeHelper.errorColor
                            : ThemeHelper.successColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: ThemeHelper.textTertiaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
