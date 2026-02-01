import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ai_pocket/core/database/app_database.dart';
import 'package:my_ai_pocket/core/routes/app_routes.dart';
import 'package:my_ai_pocket/core/database/services/bill_service.dart';
import 'package:my_ai_pocket/core/database/services/category_service.dart';
import 'home_state.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
/// 首页控制器
class HomeController extends GetxController {
  final HomeState state = HomeState();
  final BillService billService = Get.find<BillService>();
  final CategoryService categoryService = Get.find<CategoryService>();

  @override
  void onInit() {
    super.onInit();
    // 初始化逻辑
  }

  @override
  void onReady() {
    super.onReady();
    // 页面准备完成后的逻辑
    loadBills();
  }

  @override
  void onClose() {
    // 清理资源
    super.onClose();
  }

  /// 加载账单数据
  Future<void> loadBills() async {
    try {
      state.isLoading.value = true;
      
      // 使用服务类加载分类数据
      state.categoryMap.value = await categoryService.getCategoryMap();
      
      // 使用服务类加载账单数据（排除已删除的，按发生时间倒序）
      final bills = await billService.getAllBills();
      state.bills.value = bills;
    } catch (e) {
      Get.snackbar('error'.tr, '${'loadBillsFailed'.tr}：$e', snackPosition: SnackPosition.BOTTOM);
    } finally {
      state.isLoading.value = false;
    }
  }

  /// 跳转添加账单
  void addBillEvent() {
    Get.toNamed(AppRoutes.addBill)?.then((_) {
      // 返回后刷新列表
      loadBills();
    });
  }

  /// 跳转编辑账单
  void editBill(String billId) {
    Get.toNamed(AppRoutes.addBill, arguments: billId)?.then((_) {
      // 返回后刷新列表
      loadBills();
    });
  }

  /// 删除账单（软删除）
  Future<void> deleteBill(String billId) async {
    try {
      // 使用服务类软删除账单
      await billService.softDeleteBill(billId);
      
      // 刷新列表
      await loadBills();
      
      Get.snackbar('success'.tr, 'billDeleted'.tr, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('error'.tr, '${'deleteFailed'.tr}：$e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// 显示删除确认对话框
  Future<void> showDeleteConfirmDialog(String billId) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text('confirmDelete'.tr),
        content: Text('confirmDeleteBill'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('delete'.tr),
          ),
        ],
      ),
    );
    
    if (result == true) {
      await deleteBill(billId);
    }
  }

  /// 获取分类信息
  CategoryTableData? getCategory(String categoryId) {
    return state.categoryMap[categoryId];
  }

  /// 格式化金额（分转元）
  String formatAmount(int amountMinor) {
    return (amountMinor / 100).toStringAsFixed(2);
  }

  /// 格式化时间
  String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final billDate = DateTime(date.year, date.month, date.day);
    
    final timeStr = '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    
    if (billDate == today) {
      return '${'today'.tr} $timeStr';
    } else if (billDate == today.subtract(const Duration(days: 1))) {
      return '${'yesterday'.tr} $timeStr';
    } else {
      return '${date.month}/${date.day} $timeStr';
    }
  }
}
