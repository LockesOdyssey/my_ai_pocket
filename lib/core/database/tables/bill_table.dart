import 'package:drift/drift.dart';

/// 账单表
class BillTable extends Table {
  TextColumn get id => text()();
  IntColumn get type => integer()(); // 0 expense, 1 income
  IntColumn get amountMinor => integer()(); // 分
  TextColumn get categoryId => text()();
  TextColumn get accountId => text()();
  IntColumn get occurredAt => integer()(); // 发生时间（Unix 时间戳）
  TextColumn get note => text().nullable()(); // 备注/描述
  IntColumn get createdAt => integer()(); // 创建时间（Unix 时间戳）
  IntColumn get updatedAt => integer()(); // 更新时间（Unix 时间戳）
  IntColumn get deletedAt => integer().nullable()(); // 删除时间（Unix 时间戳，软删除）

  @override
  Set<Column> get primaryKey => {id};
}
