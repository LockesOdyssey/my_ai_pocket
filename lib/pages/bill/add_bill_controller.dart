import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/database/app_database.dart';
import 'add_bill_state.dart';

/// 新增账单控制器
class AddBillController extends GetxController {
  final AddBillState state = AddBillState();
  final AppDatabase database = Get.find<AppDatabase>();
  
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  
  final canSave = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 监听输入变化，更新保存按钮状态
    amountController.addListener(_checkCanSave);
    categoryController.addListener(_checkCanSave);
    accountController.addListener(_checkCanSave);
  }

  @override
  void onClose() {
    amountController.dispose();
    categoryController.dispose();
    accountController.dispose();
    noteController.dispose();
    super.onClose();
  }

  void _checkCanSave() {
    final amount = amountController.text.trim();
    final category = categoryController.text.trim();
    final account = accountController.text.trim();
    
    canSave.value = amount.isNotEmpty &&
        double.tryParse(amount) != null &&
        double.parse(amount) > 0 &&
        category.isNotEmpty &&
        account.isNotEmpty;
  }

  /// 选择类型
  void selectType(int type) {
    state.billType.value = type;
  }

  /// 更新金额
  void updateAmount(String value) {
    _checkCanSave();
  }

  /// 更新分类
  void updateCategory(String value) {
    state.categoryId.value = value.trim();
    _checkCanSave();
  }

  /// 更新账户
  void updateAccount(String value) {
    state.accountId.value = value.trim();
    _checkCanSave();
  }

  /// 更新备注
  void updateNote(String value) {
    state.note.value = value.trim();
  }

  /// 选择日期
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state.occurredAt.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(state.occurredAt.value),
      );
      if (time != null) {
        state.occurredAt.value = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
      } else {
        state.occurredAt.value = DateTime(
          picked.year,
          picked.month,
          picked.day,
          state.occurredAt.value.hour,
          state.occurredAt.value.minute,
        );
      }
    }
  }

  /// 保存账单
  Future<void> saveBill() async {
    try {
      final amount = double.parse(amountController.text.trim());
      final amountMinor = (amount * 100).toInt();
      
      final now = DateTime.now();
      final occurredAt = state.occurredAt.value;
      
      final bill = BillTableCompanion(
        id: drift.Value(const Uuid().v4()),
        type: drift.Value(state.billType.value),
        amountMinor: drift.Value(amountMinor),
        categoryId: drift.Value(state.categoryId.value),
        accountId: drift.Value(state.accountId.value),
        occurredAt: drift.Value(occurredAt.millisecondsSinceEpoch ~/ 1000),
        note: drift.Value(state.note.value.isEmpty ? null : state.note.value),
        createdAt: drift.Value(now.millisecondsSinceEpoch ~/ 1000),
        updatedAt: drift.Value(now.millisecondsSinceEpoch ~/ 1000),
        deletedAt: const drift.Value(null),
      );
      
      await database.into(database.billTable).insert(bill);
      
      Get.back();
      Get.snackbar('成功', '账单已保存', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('错误', '保存失败：$e', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
