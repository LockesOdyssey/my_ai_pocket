import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_ai_pocket/core/theme/theme_helper.dart';
import 'package:my_ai_pocket/core/utils/icon_helper.dart';
import 'package:my_ai_pocket/core/utils/decimal_text_input_formatter.dart';
import 'add_bill_controller.dart';

/// 新增账单页面
class AddBillPage extends GetView<AddBillController> {
  const AddBillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          controller.isEditMode.value ? 'editBill'.tr : 'addBill'.tr
        )),
        actions: [
          Obx(
            () => TextButton(
              onPressed: controller.canSave.value ? controller.saveBill : null,
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
              ),
              child: Text('save'.tr),
            ),
          ),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 类型选择
              _buildSectionTitle('type'.tr),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildTypeButton(
                      'expense'.tr,
                      0,
                      controller.state.billType.value == 0,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTypeButton(
                      'income'.tr,
                      1,
                      controller.state.billType.value == 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // 金额
              _buildSectionTitle('amount'.tr),
              const SizedBox(height: 8),
              TextField(
                controller: controller.amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  DecimalTextInputFormatter(maxDecimalPlaces: 2),
                ],
                decoration: InputDecoration(
                  hintText: 'amountHint'.tr,
                  prefixText: '¥ ',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) => controller.updateAmount(value),
              ),
              const SizedBox(height: 24),
              
              // 分类
              _buildSectionTitle('category'.tr),
              const SizedBox(height: 8),
              Obx(() => _buildCategoryGrid(controller)),
              const SizedBox(height: 24),
              
              // 发生时间
              _buildSectionTitle('occurredTime'.tr),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => controller.selectDate(context),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('yyyy-MM-dd HH:mm')
                            .format(controller.state.occurredAt.value),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // 备注
              _buildSectionTitle('note'.tr),
              const SizedBox(height: 8),
              TextField(
                controller: controller.noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'noteHint'.tr,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) => controller.updateNote(value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTypeButton(String label, int type, bool isSelected) {
    return InkWell(
      onTap: () => controller.selectType(type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? (type == 0 ? ThemeHelper.errorColor : ThemeHelper.successColor)
              : ThemeHelper.backgroundColor,
          border: Border.all(
            color: isSelected
                ? (type == 0 ? Colors.red : Colors.green)
                : Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : ThemeHelper.textPrimaryColor
            ),
          ),
        ),
      ),
    );
  }

  /// 构建分类网格
  Widget _buildCategoryGrid(AddBillController controller) {
    final categories = controller.currentCategories;
    
    if (categories.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text('noCategories'.tr, style: const TextStyle(color: Colors.grey)),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 每行4个
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        
        return Obx(() {
          final isSelected = controller.state.categoryId.value == category.id;
          
          return InkWell(
            onTap: () => controller.selectCategory(category.id),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? (IconHelper.hexToColor(category.color).withAlpha(51))
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? IconHelper.hexToColor(category.color)
                      : Colors.grey.withAlpha(76),
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    IconHelper.getIconData(category.iconName),
                    color: IconHelper.hexToColor(category.color),
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name.tr, // 使用国际化key获取翻译
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? IconHelper.hexToColor(category.color)
                          : ThemeHelper.textPrimaryColor,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
