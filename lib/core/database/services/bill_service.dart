import 'package:drift/drift.dart' as drift;
import '../app_database.dart';

/// 账单服务
/// 封装所有账单相关的数据库操作
class BillService {
  final AppDatabase _database;

  BillService(this._database);

  /// V1版本默认账户ID（单用户模式）
  static const String defaultAccountId = 'default_account_v1';

  /// 获取所有账单（排除已删除的）
  /// [orderByDesc] 是否按发生时间倒序，默认为 true
  Future<List<BillTableData>> getAllBills({bool orderByDesc = true}) async {
    final query = _database.select(_database.billTable)
      ..where((tbl) => tbl.deletedAt.isNull());
    
    if (orderByDesc) {
      query.orderBy([(tbl) => drift.OrderingTerm.desc(tbl.occurredAt)]);
    } else {
      query.orderBy([(tbl) => drift.OrderingTerm.asc(tbl.occurredAt)]);
    }
    
    return await query.get();
  }

  /// 根据ID获取账单
  Future<BillTableData?> getBillById(String id) async {
    try {
      final bill = await (_database.select(_database.billTable)
        ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
      return bill;
    } catch (e) {
      return null;
    }
  }

  /// 创建账单
  Future<void> createBill({
    required String id,
    required int type,
    required int amountMinor,
    required String categoryId,
    required int occurredAt,
    String? note,
    String? accountId,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    
    final bill = BillTableCompanion(
      id: drift.Value(id),
      type: drift.Value(type),
      amountMinor: drift.Value(amountMinor),
      categoryId: drift.Value(categoryId),
      accountId: drift.Value(accountId ?? defaultAccountId),
      occurredAt: drift.Value(occurredAt),
      note: drift.Value(note),
      createdAt: drift.Value(now),
      updatedAt: drift.Value(now),
      deletedAt: const drift.Value(null),
    );
    
    await _database.into(_database.billTable).insert(bill);
  }

  /// 更新账单
  Future<void> updateBill({
    required String id,
    int? type,
    int? amountMinor,
    String? categoryId,
    int? occurredAt,
    String? note,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    
    final companion = BillTableCompanion(
      type: type != null ? drift.Value(type) : const drift.Value.absent(),
      amountMinor: amountMinor != null ? drift.Value(amountMinor) : const drift.Value.absent(),
      categoryId: categoryId != null ? drift.Value(categoryId) : const drift.Value.absent(),
      occurredAt: occurredAt != null ? drift.Value(occurredAt) : const drift.Value.absent(),
      note: note != null ? drift.Value(note) : const drift.Value.absent(),
      updatedAt: drift.Value(now),
    );
    
    await (_database.update(_database.billTable)
      ..where((tbl) => tbl.id.equals(id)))
      .write(companion);
  }

  /// 软删除账单
  Future<void> softDeleteBill(String id) async {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    
    await (_database.update(_database.billTable)
      ..where((tbl) => tbl.id.equals(id)))
      .write(BillTableCompanion(
        deletedAt: drift.Value(now),
        updatedAt: drift.Value(now),
      ));
  }

  /// 恢复已删除的账单
  Future<void> restoreBill(String id) async {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    
    await (_database.update(_database.billTable)
      ..where((tbl) => tbl.id.equals(id)))
      .write(BillTableCompanion(
        deletedAt: const drift.Value(null),
        updatedAt: drift.Value(now),
      ));
  }

  /// 永久删除账单（硬删除）
  Future<void> hardDeleteBill(String id) async {
    await (_database.delete(_database.billTable)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }

  /// 根据时间范围获取账单
  Future<List<BillTableData>> getBillsByDateRange({
    required int startTimestamp,
    required int endTimestamp,
  }) async {
    final query = _database.select(_database.billTable)
      ..where((tbl) => 
        tbl.deletedAt.isNull() &
        tbl.occurredAt.isBiggerOrEqualValue(startTimestamp) &
        tbl.occurredAt.isSmallerOrEqualValue(endTimestamp));
    
    query.orderBy([(tbl) => drift.OrderingTerm.desc(tbl.occurredAt)]);
    
    return await query.get();
  }

  /// 根据类型获取账单
  Future<List<BillTableData>> getBillsByType(int type) async {
    final query = _database.select(_database.billTable)
      ..where((tbl) => 
        tbl.deletedAt.isNull() & 
        tbl.type.equals(type));
    
    query.orderBy([(tbl) => drift.OrderingTerm.desc(tbl.occurredAt)]);
    
    return await query.get();
  }
}
