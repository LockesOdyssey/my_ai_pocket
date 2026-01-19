import 'package:get/get.dart';
import 'language_state.dart';
import '../database/app_database.dart';
import '../database/services/user_config_service.dart';

/// 语言管理控制器
class LanguageController extends GetxController {
  final LanguageState state = LanguageState();
  UserConfigService? _userConfigService;

  /// 切换语言（按简体中文 -> 繁体中文 -> 英文的顺序轮流切换）
  void switchLanguage() {
    switch (state.currentLanguage.value) {
      case AppLanguage.zh:
        // 简体中文 -> 繁体中文
        setLanguage(AppLanguage.zhHant);
        break;
      case AppLanguage.zhHant:
        // 繁体中文 -> 英文
        setLanguage(AppLanguage.en);
        break;
      case AppLanguage.en:
        // 英文 -> 简体中文
        setLanguage(AppLanguage.zh);
        break;
    }
  }

  /// 设置语言
  void setLanguage(AppLanguage language) {
    state.currentLanguage.value = language;
    // 调用 Get.updateLocale 确保 GetX 的翻译系统更新
    Get.updateLocale(state.locale);
    // 保存配置到数据库
    _saveLanguageConfig();
  }

  /// 保存语言配置到数据库
  void _saveLanguageConfig() {
    try {
      if (_userConfigService == null) {
        final database = Get.find<AppDatabase>();
        _userConfigService = UserConfigService(database);
      }
      _userConfigService?.saveUserConfig(language: state.currentLanguage.value);
    } catch (e) {
      // 忽略错误，避免影响应用运行
      print('保存语言配置失败: $e');
    }
  }

  /// 设置为简体中文
  void setZh() {
    setLanguage(AppLanguage.zh);
  }

  /// 设置为繁体中文
  void setZhHant() {
    setLanguage(AppLanguage.zhHant);
  }

  /// 设置为英文
  void setEn() {
    setLanguage(AppLanguage.en);
  }

  /// 获取当前语言文本
  String getCurrentLanguageText() {
    switch (state.currentLanguage.value) {
      case AppLanguage.zh:
        return '简体中文';
      case AppLanguage.zhHant:
        return '繁体中文';
      case AppLanguage.en:
        return 'English';
    }
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化用户配置服务
    try {
      final database = Get.find<AppDatabase>();
      _userConfigService = UserConfigService(database);
    } catch (e) {
      // 如果数据库未初始化，忽略错误
      print('初始化用户配置服务失败: $e');
    }
  }
}
