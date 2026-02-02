import 'package:get/get.dart';

/// 统计页面状态
class StatisticsState {
  // 当前选中的统计类型：0=支出，1=收入，2=总计
  final RxInt selectedType = 2.obs;
  
  // 按月统计数据
  final RxList<MonthlyStatistics> monthlyStats = <MonthlyStatistics>[].obs;
  
  // 加载状态
  final RxBool isLoading = false.obs;
}

/// 按月统计数据模型
class MonthlyStatistics {
  final String yearMonth; // 格式：YYYY-MM
  final int expenseAmount; // 支出金额（分）
  final int incomeAmount; // 收入金额（分）
  
  MonthlyStatistics({
    required this.yearMonth,
    required this.expenseAmount,
    required this.incomeAmount,
  });
  
  /// 获取总计金额（收入 - 支出）
  int get totalAmount => incomeAmount - expenseAmount;
  
  /// 格式化年月显示
  String get displayYearMonth {
    final parts = yearMonth.split('-');
    if (parts.length == 2) {
      return '${parts[0]}年${int.parse(parts[1])}月';
    }
    return yearMonth;
  }
}
