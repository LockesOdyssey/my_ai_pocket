import 'package:drift/drift.dart';
import 'db_connection.dart';
import 'tables/bill_table.dart';
import 'tables/category_table.dart';
import 'tables/user_config_table.dart';
import 'seeders/category_seeder.dart';

part 'app_database.g.dart';

/// 应用数据库
@DriftDatabase(tables: [BillTable, CategoryTable, UserConfigTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // 初始化分类数据
        await CategorySeeder.seedCategories(this);
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // 数据库升级逻辑
        // 版本3：更新分类数据以支持国际化
        if (from < 3) {
          // 删除旧分类数据并重新插入（使用国际化key）
          await CategorySeeder.seedCategories(this);
        }
        // 版本4：添加用户配置表
        if (from < 4) {
          // 注意：userConfigTable 会在代码生成后可用
          // 如果编译错误，请先运行: flutter pub run build_runner build --delete-conflicting-outputs
          await m.createTable(userConfigTable);
        }
      },
    );
  }
}
