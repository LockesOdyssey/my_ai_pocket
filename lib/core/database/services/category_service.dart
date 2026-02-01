import 'package:drift/drift.dart';

import '../app_database.dart';

/// 分类服务
/// 封装所有分类相关的数据库操作
class CategoryService {
  final AppDatabase _database;

  CategoryService(this._database);

  /// 获取所有分类
  Future<List<CategoryTableData>> getAllCategories() async {
    return await _database.select(_database.categoryTable).get();
  }

  /// 获取未删除的分类
  Future<List<CategoryTableData>> getActiveCategories() async {
    return await (_database.select(_database.categoryTable)
      ..where((tbl) => tbl.deletedAt.isNull()))
      .get();
  }

  /// 根据类型获取分类
  /// [type] 0=支出，1=收入
  Future<List<CategoryTableData>> getCategoriesByType(int type) async {
    final categories = await (_database.select(_database.categoryTable)
      ..where((tbl) => 
        tbl.type.equals(type) & 
        tbl.deletedAt.isNull()))
      .get();
    
    // 按排序顺序排序
    categories.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return categories;
  }

  /// 根据ID获取分类
  Future<CategoryTableData?> getCategoryById(String id) async {
    try {
      final category = await (_database.select(_database.categoryTable)
        ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
      return category;
    } catch (e) {
      return null;
    }
  }

  /// 获取分类Map（用于快速查找）
  Future<Map<String, CategoryTableData>> getCategoryMap() async {
    final categories = await getAllCategories();
    return {
      for (var category in categories) category.id: category
    };
  }
}
