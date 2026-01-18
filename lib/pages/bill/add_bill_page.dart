import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'add_bill_controller.dart';

/// 新增账单页面
class AddBillPage extends GetView<AddBillController> {
  const AddBillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新增账单'),
        actions: [
          Obx(
            () => TextButton(
              onPressed: controller.canSave.value ? controller.saveBill : null,
              child: const Text('保存'),
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
              _buildSectionTitle('类型'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildTypeButton(
                      '支出',
                      0,
                      controller.state.billType.value == 0,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTypeButton(
                      '收入',
                      1,
                      controller.state.billType.value == 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // 金额
              _buildSectionTitle('金额'),
              const SizedBox(height: 8),
              TextField(
                controller: controller.amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: '请输入金额',
                  prefixText: '¥ ',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => controller.updateAmount(value),
              ),
              const SizedBox(height: 24),
              
              // 分类
              _buildSectionTitle('分类'),
              const SizedBox(height: 8),
              TextField(
                controller: controller.categoryController,
                decoration: const InputDecoration(
                  hintText: '请输入分类ID',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => controller.updateCategory(value),
              ),
              const SizedBox(height: 24),
              
              // 账户
              _buildSectionTitle('账户'),
              const SizedBox(height: 8),
              TextField(
                controller: controller.accountController,
                decoration: const InputDecoration(
                  hintText: '请输入账户ID',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => controller.updateAccount(value),
              ),
              const SizedBox(height: 24),
              
              // 发生时间
              _buildSectionTitle('发生时间'),
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
              _buildSectionTitle('备注'),
              const SizedBox(height: 8),
              TextField(
                controller: controller.noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: '请输入备注（可选）',
                  border: OutlineInputBorder(),
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
              ? (type == 0 ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1))
              : Colors.grey.withOpacity(0.1),
          border: Border.all(
            color: isSelected
                ? (type == 0 ? Colors.red : Colors.green)
                : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? (type == 0 ? Colors.red : Colors.green)
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
