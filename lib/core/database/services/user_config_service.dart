import 'package:drift/drift.dart';
import '../app_database.dart';
import '../../theme/theme_state.dart';
import '../../language/language_state.dart';

/// 用户配置服务
/// 用于管理用户配置的读取和保存
class UserConfigService {
  final AppDatabase _database;

  UserConfigService(this._database);

  /// 默认账户ID
  static const String defaultAccountId = 'default';

  /// 获取用户配置
  /// [accountId] 账户ID，默认为 'default'
  Future<UserConfigTableData?> getUserConfig({String accountId = defaultAccountId}) async {
    try {
      final query = _database.select(_database.userConfigTable)
        ..where((tbl) => tbl.accountId.equals(accountId));
      final configs = await query.get();
      return configs.isNotEmpty ? configs.first : null;
    } catch (e) {
      return null;
    }
  }

  /// 保存或更新用户配置
  /// [accountId] 账户ID，默认为 'default'
  /// [themeMode] 主题模式，null 表示不更新
  /// [language] 语言设置，null 表示不更新
  Future<void> saveUserConfig({
    String accountId = defaultAccountId,
    AppThemeMode? themeMode,
    AppLanguage? language,
  }) async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      
      // 检查配置是否存在
      final existing = await getUserConfig(accountId: accountId);
      
      if (existing != null) {
        // 更新现有配置
        final companion = UserConfigTableCompanion(
          updatedAt: Value(now),
          themeMode: themeMode != null ? Value(_themeModeToInt(themeMode)) : const Value.absent(),
          language: language != null ? Value(_languageToInt(language)) : const Value.absent(),
        );
        await (_database.update(_database.userConfigTable)
          ..where((tbl) => tbl.accountId.equals(accountId)))
            .write(companion);
      } else {
        // 创建新配置
        final companion = UserConfigTableCompanion(
          accountId: Value(accountId),
          themeMode: Value(themeMode != null ? _themeModeToInt(themeMode) : 2), // 默认跟随系统
          language: Value(language != null ? _languageToInt(language) : 0), // 默认简体中文
          createdAt: Value(now),
          updatedAt: Value(now),
        );
        await _database.into(_database.userConfigTable).insert(companion);
      }
    } catch (e) {
      // 忽略错误，避免影响应用运行
      print('保存用户配置失败: $e');
    }
  }

  /// 加载用户配置并应用到控制器
  /// [themeController] 主题控制器
  /// [languageController] 语言控制器
  /// [accountId] 账户ID，默认为 'default'
  Future<void> loadUserConfig({
    required dynamic themeController,
    required dynamic languageController,
    String accountId = defaultAccountId,
  }) async {
    try {
      final config = await getUserConfig(accountId: accountId);
      if (config != null) {
        // 应用主题配置
        final themeMode = _intToThemeMode(config.themeMode);
        if (themeMode != null) {
          themeController.setThemeMode(themeMode);
        }
        
        // 应用语言配置
        final language = _intToLanguage(config.language);
        if (language != null) {
          languageController.setLanguage(language);
        }
      }
    } catch (e) {
      // 忽略错误，使用默认配置
      print('加载用户配置失败: $e');
    }
  }

  /// 主题模式转整数
  int _themeModeToInt(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 0;
      case AppThemeMode.dark:
        return 1;
      case AppThemeMode.system:
        return 2;
    }
  }

  /// 整数转主题模式
  AppThemeMode? _intToThemeMode(int value) {
    switch (value) {
      case 0:
        return AppThemeMode.light;
      case 1:
        return AppThemeMode.dark;
      case 2:
        return AppThemeMode.system;
      default:
        return null;
    }
  }

  /// 语言转整数
  int _languageToInt(AppLanguage language) {
    switch (language) {
      case AppLanguage.zh:
        return 0;
      case AppLanguage.zhHant:
        return 1;
      case AppLanguage.en:
        return 2;
    }
  }

  /// 整数转语言
  AppLanguage? _intToLanguage(int value) {
    switch (value) {
      case 0:
        return AppLanguage.zh;
      case 1:
        return AppLanguage.zhHant;
      case 2:
        return AppLanguage.en;
      default:
        return null;
    }
  }
}
