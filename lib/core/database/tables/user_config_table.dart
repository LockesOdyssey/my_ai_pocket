import 'package:drift/drift.dart';

/// 用户配置表
/// 用于保存用户的主题、语言等设置
class UserConfigTable extends Table {
  /// 账户ID，用于多用户支持
  /// 默认值为 'default' 表示默认用户
  TextColumn get accountId => text().withDefault(const Constant('default'))();
  
  /// 主题模式：0=浅色(light), 1=深色(dark), 2=跟随系统(system)
  IntColumn get themeMode => integer().withDefault(const Constant(2))();
  
  /// 语言设置：0=简体中文(zh), 1=繁体中文(zhHant), 2=英文(en)
  IntColumn get language => integer().withDefault(const Constant(0))();
  
  /// 创建时间（Unix 时间戳）
  IntColumn get createdAt => integer()();
  
  /// 更新时间（Unix 时间戳）
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {accountId};
}
