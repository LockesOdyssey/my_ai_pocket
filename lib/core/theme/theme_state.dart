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
  /// 注意：当为 system 模式时，此方法无法准确判断，需要使用 ThemeHelper.isDarkMode(BuildContext)
  bool get isDarkMode {
    if (themeMode.value == AppThemeMode.dark) return true;
    if (themeMode.value == AppThemeMode.light) return false;
    // system 模式需要 context 才能准确判断，这里返回 false 作为默认值
    // 实际使用时应该通过 ThemeHelper.isDarkMode(context) 获取
    return false;
  }
}
