import 'package:drift/drift.dart';
import 'db_connection.dart';
import 'tables/bill_table.dart';

part 'app_database.g.dart';

/// 应用数据库
@DriftDatabase(tables: [BillTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // 数据库升级逻辑
      },
    );
  }
}
