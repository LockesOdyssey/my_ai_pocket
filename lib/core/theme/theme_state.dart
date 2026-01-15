import 'package:get/get.dart';

/// 应用主题模式枚举
enum AppThemeMode {
  light, // 浅色模式
  dark, // 深色模式
  system, // 跟随系统
}

/// 主题状态
class ThemeState {
  // 当前主题模式
  final Rx<AppThemeMode> themeMode;

  ThemeState() : themeMode = AppThemeMode.system.obs;

  /// 是否为深色模式
  bool get isDarkMode {
    if (themeMode.value == AppThemeMode.dark) return true;
    if (themeMode.value == AppThemeMode.light) return false;
    // 跟随系统时，需要根据系统设置判断（这里简化处理，默认返回false）
    // 实际使用时可以通过 MediaQuery.platformBrightnessOf(context) 获取
    return false;
  }
}
