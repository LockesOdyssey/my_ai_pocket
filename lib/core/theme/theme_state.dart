import 'dart:ui';

import 'package:flutter/widgets.dart';
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
  /// 
  /// 注意：当为 system 模式时，此方法会尝试通过系统亮度判断
  /// 但为了更准确的判断，建议使用 ThemeHelper.isDarkMode 或 ThemeHelper.isDarkModeWithContext(BuildContext)
  bool get isDarkMode {
    if (themeMode.value == AppThemeMode.dark) return true;
    if (themeMode.value == AppThemeMode.light) return false;
    
    // system 模式：尝试通过系统亮度判断
    if (themeMode.value == AppThemeMode.system) {
      try {
        // 使用 WidgetsBinding 获取系统亮度
        final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark;
      } catch (e) {
        // 如果获取失败，默认返回浅色模式
        return false;
      }
    }
    
    // 默认返回浅色模式
    return false;
  }
}
