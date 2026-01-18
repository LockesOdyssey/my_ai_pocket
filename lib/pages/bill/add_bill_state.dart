import 'package:get/get.dart';

/// 新增账单状态
class AddBillState {
  // 账单类型：0=支出，1=收入
  final billType = 0.obs;
  
  // 金额（分）
  final amountMinor = 0.obs;
  
  // 分类ID
  final categoryId = ''.obs;
  
  // 账户ID
  final accountId = ''.obs;
  
  // 发生时间
  final occurredAt = DateTime.now().obs;
  
  // 备注
  final note = ''.obs;
}
