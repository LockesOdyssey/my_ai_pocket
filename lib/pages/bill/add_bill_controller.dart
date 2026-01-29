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
  final TextEditingController noteController = TextEditingController();
  
  final canSave = false.obs;
  
  // 编辑模式标识
  final isEditMode = false.obs;
  String? billId; // 编辑时的账单ID
  
  /// V1版本默认账户ID（单用户模式）
  static const String defaultAccountId = 'default_account_v1';
  
  // 所有分类数据
  final allCategories = <CategoryTableData>[].obs;
  
  // 当前显示的分类（根据类型过滤）
  List<CategoryTableData> get currentCategories {
    return allCategories
        .where((category) => category.type == state.billType.value && category.deletedAt == null)
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }

  @override
  void onInit() {
    super.onInit();
    // 从路由参数获取账单ID（编辑模式）
    final arguments = Get.arguments;
    if (arguments != null && arguments is String) {
      billId = arguments;
      isEditMode.value = true;
    }
    
    // 监听输入变化，更新保存按钮状态
    amountController.addListener(_checkCanSave);
    categoryController.addListener(_checkCanSave);
    // 监听类型变化，清空已选分类（仅在新增模式）
    ever(state.billType, (_) {
      if (!isEditMode.value) {
        state.categoryId.value = '';
        categoryController.clear();
      }
    });
    // 加载分类数据
    loadCategories().then((_) {
      // 如果是编辑模式，加载账单数据
      if (isEditMode.value && billId != null) {
        loadBillData(billId!);
      }
    });
  }
  
  /// 加载分类数据
  Future<void> loadCategories() async {
    try {
      final categories = await database.select(database.categoryTable).get();
      allCategories.value = categories;
    } catch (e) {
      Get.snackbar('error'.tr, '${'loadCategoriesFailed'.tr}：$e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// 加载账单数据（编辑模式）
  Future<void> loadBillData(String id) async {
    try {
      final bill = await (database.select(database.billTable)
        ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
      
      // 填充表单数据
      state.billType.value = bill.type;
      state.categoryId.value = bill.categoryId;
      amountController.text = (bill.amountMinor / 100).toStringAsFixed(2);
      noteController.text = bill.note ?? '';
      state.note.value = bill.note ?? '';
      state.occurredAt.value = DateTime.fromMillisecondsSinceEpoch(bill.occurredAt * 1000);
      
      // 设置分类显示文本
      final category = allCategories.firstWhereOrNull((c) => c.id == bill.categoryId);
      if (category != null) {
        categoryController.text = category.name.tr;
      }
      
      _checkCanSave();
    } catch (e) {
      Get.snackbar('error'.tr, '${'loadBillFailed'.tr}：$e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    amountController.dispose();
    categoryController.dispose();
    noteController.dispose();
    super.onClose();
  }

  void _checkCanSave() {
    final amount = amountController.text.trim();
    
    canSave.value = amount.isNotEmpty &&
        double.tryParse(amount) != null &&
        double.parse(amount) > 0 &&
        state.categoryId.value.isNotEmpty;
  }

  /// 选择类型
  void selectType(int type) {
    state.billType.value = type;
    // 切换类型时清空已选分类（因为新类型下的分类列表不同）
    // 检查当前分类是否在新类型的分类列表中
    final currentCategory = allCategories.firstWhereOrNull((c) => c.id == state.categoryId.value);
    if (currentCategory == null || currentCategory.type != type) {
      state.categoryId.value = '';
      categoryController.clear();
    }
  }
  
  /// 选择分类
  void selectCategory(String categoryId) {
    state.categoryId.value = categoryId;
    final category = allCategories.firstWhereOrNull((c) => c.id == categoryId);
    if (category != null) {
      categoryController.text = category.name.tr; // 使用国际化key获取翻译
    }
    _checkCanSave();
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

  /// 保存账单（支持新增和编辑）
  Future<void> saveBill() async {
    try {
      final amount = double.parse(amountController.text.trim());
      final amountMinor = (amount * 100).toInt();
      final now = DateTime.now();
      final occurredAt = state.occurredAt.value;
      
      if (isEditMode.value && billId != null) {
        // 编辑模式：更新
        await (database.update(database.billTable)
          ..where((tbl) => tbl.id.equals(billId!)))
          .write(BillTableCompanion(
            type: drift.Value(state.billType.value),
            amountMinor: drift.Value(amountMinor),
            categoryId: drift.Value(state.categoryId.value),
            occurredAt: drift.Value(occurredAt.millisecondsSinceEpoch ~/ 1000),
            note: drift.Value(state.note.value.isEmpty ? null : state.note.value),
            updatedAt: drift.Value(now.millisecondsSinceEpoch ~/ 1000),
          ));
        Get.back();
        Get.snackbar('success'.tr, 'billUpdated'.tr, snackPosition: SnackPosition.BOTTOM);
      } else {
        // 新增模式：插入
        final bill = BillTableCompanion(
          id: drift.Value(const Uuid().v4()),
          type: drift.Value(state.billType.value),
          amountMinor: drift.Value(amountMinor),
          categoryId: drift.Value(state.categoryId.value),
          accountId: drift.Value(defaultAccountId), // V1版本使用默认账户ID
          occurredAt: drift.Value(occurredAt.millisecondsSinceEpoch ~/ 1000),
          note: drift.Value(state.note.value.isEmpty ? null : state.note.value),
          createdAt: drift.Value(now.millisecondsSinceEpoch ~/ 1000),
          updatedAt: drift.Value(now.millisecondsSinceEpoch ~/ 1000),
          deletedAt: const drift.Value(null),
        );
        
        await database.into(database.billTable).insert(bill);
        Get.back();
        Get.snackbar('success'.tr, 'billSaved'.tr, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('error'.tr, '${'saveFailed'.tr}：$e', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
