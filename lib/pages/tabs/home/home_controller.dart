import 'package:get/get.dart';
import 'package:drift/drift.dart';
import 'package:my_ai_pocket/core/routes/app_routes.dart';
import 'package:my_ai_pocket/core/database/app_database.dart';
import 'home_state.dart';

/// 首页控制器
class HomeController extends GetxController {
  final HomeState state = HomeState();
  final AppDatabase database = Get.find<AppDatabase>();

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
      
      // 加载分类数据
      final categories = await database.select(database.categoryTable).get();
      state.categoryMap.value = {
        for (var category in categories) category.id: category
      };
      
      // 加载账单数据（排除已删除的，按发生时间倒序）
      final bills = await (database.select(database.billTable)
        ..where((tbl) => tbl.deletedAt.isNull())
        ..orderBy([(tbl) => OrderingTerm.desc(tbl.occurredAt)]))
        .get();
      
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
