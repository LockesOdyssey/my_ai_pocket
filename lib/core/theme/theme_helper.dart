import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';
import 'theme_controller.dart';
import 'theme_state.dart';

/// 主题辅助类，提供便捷的颜色访问方法
class ThemeHelper {
  ThemeHelper._();

  /// 获取主题控制器
  static ThemeController get controller => Get.find<ThemeController>();

  /// 获取当前是否为深色模式
  /// 
  /// 注意：当主题模式为 system 时，会通过系统亮度来判断
  /// 如果需要更准确的判断（基于当前 Widget 的 context），请使用 isDarkMode(BuildContext)
  static bool get isDarkMode {
    final themeMode = controller.state.themeMode.value;
    
    // 明确指定浅色或深色模式
    if (themeMode == AppThemeMode.light) return false;
    if (themeMode == AppThemeMode.dark) return true;
    
    // 跟随系统模式：通过系统亮度判断
    if (themeMode == AppThemeMode.system) {
      return _getSystemBrightness() == Brightness.dark;
    }
    
    // 默认返回浅色模式
    return false;
  }

  /// 获取当前是否为深色模式（基于 BuildContext）
  /// 
  /// 此方法可以更准确地判断深色模式，特别是在跟随系统模式下
  /// 它会根据当前 Widget 树中的实际主题来判断
  /// 
  /// 推荐在 Widget 的 build 方法中使用此方法
  /// 
  /// 示例：
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///   final isDark = ThemeHelper.isDarkModeWithContext(context);
  ///   return Container(color: isDark ? Colors.black : Colors.white);
  /// }
  /// ```
  static bool isDarkModeWithContext(BuildContext context) {
    final themeMode = controller.state.themeMode.value;
    
    // 明确指定浅色或深色模式
    if (themeMode == AppThemeMode.light) return false;
    if (themeMode == AppThemeMode.dark) return true;
    
    // 跟随系统模式：通过 MediaQuery 获取系统亮度
    if (themeMode == AppThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    
    // 默认返回浅色模式
    return false;
  }

  /// 获取当前是否为深色模式（便捷方法，支持可选 context）
  /// 
  /// 如果提供了 context，会使用更准确的判断方式
  /// 如果没有提供 context，会使用系统亮度判断
  /// 
  /// 示例：
  /// ```dart
  /// // 在 Widget 中使用（推荐）
  /// final isDark = ThemeHelper.isDarkMode(context);
  /// 
  /// // 在非 Widget 环境中使用
  /// final isDark = ThemeHelper.isDarkMode();
  /// ```
  static bool isDarkModeOptional([BuildContext? context]) {
    if (context != null) {
      return isDarkModeWithContext(context);
    }
    return isDarkMode;
  }

  /// 获取系统亮度
  /// 使用 WidgetsBinding 来获取系统级别的亮度设置
  static Brightness _getSystemBrightness() {
    try {
      // 尝试从 WidgetsBinding 获取系统亮度
      return WidgetsBinding.instance.platformDispatcher.platformBrightness;
    } catch (e) {
      // 如果获取失败，默认返回浅色模式
      return Brightness.light;
    }
  }

  /// 获取当前主题的颜色
  static T getColor<T>(
    T Function(LightColors colors) light,
    T Function(DarkColors colors) dark,
  ) {
    return isDarkMode ? dark(AppColors.dark) : light(AppColors.light);
  }

  /// 获取背景色
  static Color get backgroundColor => isDarkMode 
      ? AppColors.dark.background 
      : AppColors.light.background;

  /// 获取表面色
  static Color get surfaceColor => isDarkMode 
      ? AppColors.dark.surface 
      : AppColors.light.surface;

  /// 获取卡片颜色
  static Color get cardColor => isDarkMode 
      ? AppColors.dark.card 
      : AppColors.light.card;

  /// 获取主要文字颜色
  static Color get textPrimaryColor => isDarkMode 
      ? AppColors.dark.textPrimary 
      : AppColors.light.textPrimary;

  /// 获取次要文字颜色
  static Color get textSecondaryColor => isDarkMode 
      ? AppColors.dark.textSecondary 
      : AppColors.light.textSecondary;

  /// 获取三级文字颜色
  static Color get textTertiaryColor => isDarkMode 
      ? AppColors.dark.textTertiary 
      : AppColors.light.textTertiary;

  /// 获取主题色
  static Color get primaryColor => AppColors.primary;

  /// 获取成功色
  static Color get successColor => isDarkMode 
      ? AppColors.dark.success 
      : AppColors.light.success;

  /// 获取警告色
  static Color get warningColor => isDarkMode 
      ? AppColors.dark.warning 
      : AppColors.light.warning;

  /// 获取错误色
  static Color get errorColor => isDarkMode 
      ? AppColors.dark.error 
      : AppColors.light.error;

  /// 获取强调色
  static Color get accentColor => isDarkMode 
      ? AppColors.dark.accent 
      : AppColors.light.accent;

  /// 获取分割线颜色
  static Color get dividerColor => isDarkMode 
      ? AppColors.dark.divider 
      : AppColors.light.divider;

  /// 获取边框颜色
  static Color get borderColor => isDarkMode 
      ? AppColors.dark.border 
      : AppColors.light.border;
}
