import 'package:drift/drift.dart';

/// 分类表
class CategoryTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()(); // 分类名称
  IntColumn get type => integer()(); // 0 expense（支出）, 1 income（收入）
  TextColumn get color => text()(); // 颜色值（十六进制，如 #FF5722）
  
  // 图标相关字段 - 支持多种图标类型扩展
  // iconType: 0=系统图标, 1=本地图片, 2=网络URL
  IntColumn get iconType => integer().withDefault(const Constant(0))(); // 图标类型
  TextColumn get iconName => text().nullable()(); // 系统图标名称（iconType=0时使用，如 Icons.food_bank 对应的名称）
  TextColumn get localImagePath => text().nullable()(); // 本地图片路径（iconType=1时使用）
  TextColumn get iconUrl => text().nullable()(); // 网络图标URL（iconType=2时使用）
  
  IntColumn get sortOrder => integer().withDefault(const Constant(0))(); // 排序顺序
  IntColumn get createdAt => integer()(); // 创建时间（Unix 时间戳）
  IntColumn get updatedAt => integer()(); // 更新时间（Unix 时间戳）
  IntColumn get deletedAt => integer().nullable()(); // 删除时间（Unix 时间戳，软删除）

  @override
  Set<Column> get primaryKey => {id};
}