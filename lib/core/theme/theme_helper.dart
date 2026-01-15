import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';
import 'theme_controller.dart';

/// 主题辅助类，提供便捷的颜色访问方法
class ThemeHelper {
  ThemeHelper._();

  /// 获取主题控制器
  static ThemeController get controller => Get.find<ThemeController>();

  /// 获取当前是否为深色模式
  static bool get isDarkMode => controller.state.isDarkMode;

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
