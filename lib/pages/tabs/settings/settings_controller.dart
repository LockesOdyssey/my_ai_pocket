import 'package:get/get.dart';
import 'package:my_ai_pocket/core/theme/theme_controller.dart';
import 'package:my_ai_pocket/core/theme/theme_state.dart';
import 'package:my_ai_pocket/core/language/language_controller.dart';
import 'settings_state.dart';

/// 设置页面控制器
class SettingsController extends GetxController {
  final SettingsState state = SettingsState();

  // 获取主题控制器
  ThemeController get themeController => Get.find<ThemeController>();
  
  // 获取语言控制器
  LanguageController get languageController => Get.find<LanguageController>();

  @override
  void onInit() {
    super.onInit();
    // 初始化逻辑
    // 注意：配置保存由 ThemeController 和 LanguageController 内部处理
  }

  /// 切换语言（按简体中文 -> 繁体中文 -> 英文的顺序轮流切换）
  /// 配置会自动保存到数据库
  void switchLanguage() {
    languageController.switchLanguage();
    // 语言控制器内部已经保存配置，这里不需要额外操作
  }

  /// 获取当前语言文本
  String getCurrentLanguageText() {
    return languageController.getCurrentLanguageText();
  }

  /// 切换主题（按深色模式 -> 浅色模式 -> 跟随系统的顺序轮流切换）
  /// 配置会自动保存到数据库
  void switchTheme() {
    final currentMode = themeController.state.themeMode.value;
    
    switch (currentMode) {
      case AppThemeMode.dark:
        // 深色模式 -> 浅色模式
        themeController.setLightMode();
        break;
      case AppThemeMode.light:
        // 浅色模式 -> 跟随系统
        themeController.setSystemMode();
        break;
      case AppThemeMode.system:
        // 跟随系统 -> 深色模式
        themeController.setDarkMode();
        break;
    }
    // 主题控制器内部已经保存配置，这里不需要额外操作
  }

  /// 获取当前主题模式文本（使用翻译）
  String getCurrentThemeText() {
    final currentMode = themeController.state.themeMode.value;
    switch (currentMode) {
      case AppThemeMode.dark:
        return 'darkMode'.tr;
      case AppThemeMode.light:
        return 'lightMode'.tr;
      case AppThemeMode.system:
        return 'systemMode'.tr;
    }
  }

  /// 显示关于页面
  void showAbout() {
    // TODO: 实现关于页面
  }
}
