import 'package:get/get.dart';
import 'package:my_ai_pocket/core/database/services/bill_service.dart';
import 'statistics_state.dart';

/// 统计页面控制器
class StatisticsController extends GetxController {
  final StatisticsState state = StatisticsState();
  final BillService billService = Get.find<BillService>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadStatistics();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 加载统计数据
  Future<void> loadStatistics() async {
    try {
      state.isLoading.value = true;
      
      // 获取所有账单
      final bills = await billService.getAllBills(orderByDesc: false);
      
      // 按月统计数据
      final Map<String, MonthlyStatistics> statsMap = {};
      
      for (final bill in bills) {
        final date = DateTime.fromMillisecondsSinceEpoch(bill.occurredAt * 1000);
        final yearMonth = '${date.year}-${date.month.toString().padLeft(2, '0')}';
        
        if (!statsMap.containsKey(yearMonth)) {
          statsMap[yearMonth] = MonthlyStatistics(
            yearMonth: yearMonth,
            expenseAmount: 0,
            incomeAmount: 0,
          );
        }
        
        final stats = statsMap[yearMonth]!;
        if (bill.type == 0) {
          // 支出
          statsMap[yearMonth] = MonthlyStatistics(
            yearMonth: yearMonth,
            expenseAmount: stats.expenseAmount + bill.amountMinor,
            incomeAmount: stats.incomeAmount,
          );
        } else {
          // 收入
          statsMap[yearMonth] = MonthlyStatistics(
            yearMonth: yearMonth,
            expenseAmount: stats.expenseAmount,
            incomeAmount: stats.incomeAmount + bill.amountMinor,
          );
        }
      }
      
      // 转换为列表并按年月倒序排列
      final statsList = statsMap.values.toList();
      statsList.sort((a, b) => b.yearMonth.compareTo(a.yearMonth));
      
      state.monthlyStats.value = statsList;
    } catch (e) {
      Get.snackbar('error'.tr, '${'loadBillsFailed'.tr}：$e', snackPosition: SnackPosition.BOTTOM);
    } finally {
      state.isLoading.value = false;
    }
  }

  /// 切换统计类型
  void switchType(int type) {
    state.selectedType.value = type;
  }

  /// 格式化金额（分转元）
  String formatAmount(int amountMinor) {
    return (amountMinor / 100).toStringAsFixed(2);
  }

  /// 获取当前选中类型的金额
  int getCurrentAmount(MonthlyStatistics stats) {
    switch (state.selectedType.value) {
      case 0: // 支出
        return stats.expenseAmount;
      case 1: // 收入
        return stats.incomeAmount;
      case 2: // 总计
        return stats.totalAmount;
      default:
        return 0;
    }
  }
}
