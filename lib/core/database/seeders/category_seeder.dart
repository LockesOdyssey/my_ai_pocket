import 'package:drift/drift.dart';
import '../app_database.dart';

/// 分类数据初始化器
class CategorySeeder {
  /// 初始化分类数据
  /// 如果数据库中已有分类数据，则删除旧数据并重新插入（支持国际化）
  static Future<void> seedCategories(AppDatabase database) async {
    // 删除所有现有分类数据（支持数据迁移和更新）
    await database.delete(database.categoryTable).go();

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final categories = <CategoryTableCompanion>[];

    // 支出分类（0 = expense）- 使用国际化key
    final expenseCategories = [
      {'nameKey': 'category.food', 'color': '#FF5722', 'iconName': 'restaurant', 'sortOrder': 1},
      {'nameKey': 'category.transport', 'color': '#2196F3', 'iconName': 'directions_car', 'sortOrder': 2},
      {'nameKey': 'category.shopping', 'color': '#E91E63', 'iconName': 'shopping_cart', 'sortOrder': 3},
      {'nameKey': 'category.entertainment', 'color': '#9C27B0', 'iconName': 'movie', 'sortOrder': 4},
      {'nameKey': 'category.medical', 'color': '#F44336', 'iconName': 'local_hospital', 'sortOrder': 5},
      {'nameKey': 'category.education', 'color': '#3F51B5', 'iconName': 'school', 'sortOrder': 6},
      {'nameKey': 'category.housing', 'color': '#FF9800', 'iconName': 'home', 'sortOrder': 7},
      {'nameKey': 'category.communication', 'color': '#00BCD4', 'iconName': 'phone', 'sortOrder': 8},
      {'nameKey': 'category.utilities', 'color': '#4CAF50', 'iconName': 'flash_on', 'sortOrder': 9},
      {'nameKey': 'category.other', 'color': '#9E9E9E', 'iconName': 'more_horiz', 'sortOrder': 10},
    ];

    // 收入分类（1 = income）- 使用国际化key
    final incomeCategories = [
      {'nameKey': 'category.salary', 'color': '#4CAF50', 'iconName': 'account_balance_wallet', 'sortOrder': 1},
      {'nameKey': 'category.bonus', 'color': '#FF9800', 'iconName': 'card_giftcard', 'sortOrder': 2},
      {'nameKey': 'category.investment', 'color': '#2196F3', 'iconName': 'trending_up', 'sortOrder': 3},
      {'nameKey': 'category.partTime', 'color': '#9C27B0', 'iconName': 'work', 'sortOrder': 4},
      {'nameKey': 'category.finance', 'color': '#00BCD4', 'iconName': 'savings', 'sortOrder': 5},
      {'nameKey': 'category.redPacket', 'color': '#E91E63', 'iconName': 'redeem', 'sortOrder': 6},
      {'nameKey': 'category.refund', 'color': '#FF5722', 'iconName': 'assignment_return', 'sortOrder': 7},
      {'nameKey': 'category.other', 'color': '#9E9E9E', 'iconName': 'more_horiz', 'sortOrder': 8},
    ];

    // 生成支出分类
    for (var i = 0; i < expenseCategories.length; i++) {
      final category = expenseCategories[i];
      categories.add(
        CategoryTableCompanion(
          id: Value('expense_${i + 1}'),
          name: Value(category['nameKey'] as String), // 存储国际化key
          type: const Value(0), // 支出
          color: Value(category['color'] as String),
          iconType: const Value(0), // 系统图标
          iconName: Value(category['iconName'] as String),
          sortOrder: Value(category['sortOrder'] as int),
          createdAt: Value(now),
          updatedAt: Value(now),
          deletedAt: const Value(null),
        ),
      );
    }

    // 生成收入分类
    for (var i = 0; i < incomeCategories.length; i++) {
      final category = incomeCategories[i];
      categories.add(
        CategoryTableCompanion(
          id: Value('income_${i + 1}'),
          name: Value(category['nameKey'] as String), // 存储国际化key
          type: const Value(1), // 收入
          color: Value(category['color'] as String),
          iconType: const Value(0), // 系统图标
          iconName: Value(category['iconName'] as String),
          sortOrder: Value(category['sortOrder'] as int),
          createdAt: Value(now),
          updatedAt: Value(now),
          deletedAt: const Value(null),
        ),
      );
    }

    // 批量插入分类数据
    await database.batch((batch) {
      batch.insertAll(database.categoryTable, categories);
    });
  }
}
