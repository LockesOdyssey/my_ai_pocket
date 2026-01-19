import 'package:get/get.dart';
import '../../../core/database/app_database.dart';

/// 首页状态
class HomeState {
  // 账单列表
  final RxList<BillTableData> bills = <BillTableData>[].obs;
  
  // 分类映射（categoryId -> CategoryTableData）
  final RxMap<String, CategoryTableData> categoryMap = <String, CategoryTableData>{}.obs;
  
  // 加载状态
  final RxBool isLoading = false.obs;
}
