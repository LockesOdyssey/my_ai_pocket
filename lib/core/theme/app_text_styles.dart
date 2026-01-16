import 'package:flutter/material.dart';
import 'theme_helper.dart';

/// 应用文本样式定义类
/// 用于统一管理全局通用的文本样式
class AppTextStyles {
  AppTextStyles._();

  // ==================== 标题样式 ====================

  /// 超大标题样式
  /// 用于页面主标题
  static TextStyle get displayLarge => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: ThemeHelper.textPrimaryColor,
        height: 1.2,
        letterSpacing: -0.5,
      );

  /// 大标题样式
  /// 用于重要标题
  static TextStyle get displayMedium => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: ThemeHelper.textPrimaryColor,
        height: 1.3,
        letterSpacing: -0.3,
      );

  /// 中标题样式
  /// 用于章节标题
  static TextStyle get displaySmall => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: ThemeHelper.textPrimaryColor,
        height: 1.3,
        letterSpacing: -0.2,
      );

  /// 小标题样式
  /// 用于卡片标题、列表标题
  static TextStyle get headlineMedium => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: ThemeHelper.textPrimaryColor,
        height: 1.4,
        letterSpacing: 0,
      );

  /// 超小标题样式
  /// 用于小卡片标题
  static TextStyle get headlineSmall => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ThemeHelper.textPrimaryColor,
        height: 1.4,
        letterSpacing: 0,
      );

  // ==================== 正文样式 ====================

  /// 大正文样式
  /// 用于重要正文内容
  static TextStyle get bodyLarge => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: ThemeHelper.textPrimaryColor,
        height: 1.5,
        letterSpacing: 0.1,
      );

  /// 标准正文样式
  /// 用于常规正文内容
  static TextStyle get bodyMedium => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: ThemeHelper.textPrimaryColor,
        height: 1.5,
        letterSpacing: 0.1,
      );

  /// 小正文样式
  /// 用于次要正文内容
  static TextStyle get bodySmall => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: ThemeHelper.textSecondaryColor,
        height: 1.5,
        letterSpacing: 0.1,
      );

  // ==================== 标签样式 ====================

  /// 标签文字样式
  /// 用于标签、徽章等
  static TextStyle get labelLarge => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ThemeHelper.textPrimaryColor,
        height: 1.4,
        letterSpacing: 0.2,
      );

  /// 小标签文字样式
  static TextStyle get labelMedium => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ThemeHelper.textPrimaryColor,
        height: 1.4,
        letterSpacing: 0.2,
      );

  /// 超小标签文字样式
  static TextStyle get labelSmall => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: ThemeHelper.textSecondaryColor,
        height: 1.4,
        letterSpacing: 0.2,
      );

  // ==================== 按钮样式 ====================

  /// 大按钮文字样式
  static TextStyle get buttonLarge => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.2,
        letterSpacing: 0.5,
      );

  /// 标准按钮文字样式
  static TextStyle get buttonMedium => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.2,
        letterSpacing: 0.3,
      );

  /// 小按钮文字样式
  static TextStyle get buttonSmall => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.2,
        letterSpacing: 0.2,
      );

  /// 文字按钮样式（无背景）
  static TextStyle get buttonText => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: ThemeHelper.primaryColor,
        height: 1.2,
        letterSpacing: 0.3,
      );

  // ==================== 辅助文字样式 ====================

  /// 次要文字样式
  /// 用于说明、提示等次要信息
  static TextStyle get caption => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: ThemeHelper.textSecondaryColor,
        height: 1.4,
        letterSpacing: 0.1,
      );

  /// 三级文字样式
  /// 用于最次要的信息
  static TextStyle get overline => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: ThemeHelper.textTertiaryColor,
        height: 1.4,
        letterSpacing: 0.3,
      );

  // ==================== 功能文字样式 ====================

  /// 链接文字样式
  static TextStyle get link => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: ThemeHelper.primaryColor,
        height: 1.5,
        letterSpacing: 0.1,
        decoration: TextDecoration.underline,
        decorationColor: ThemeHelper.primaryColor,
      );

  /// 成功文字样式
  static TextStyle get success => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: ThemeHelper.successColor,
        height: 1.5,
        letterSpacing: 0.1,
      );

  /// 警告文字样式
  static TextStyle get warning => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: ThemeHelper.warningColor,
        height: 1.5,
        letterSpacing: 0.1,
      );

  /// 错误文字样式
  static TextStyle get error => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: ThemeHelper.errorColor,
        height: 1.5,
        letterSpacing: 0.1,
      );

  /// 强调文字样式
  static TextStyle get accent => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: ThemeHelper.accentColor,
        height: 1.5,
        letterSpacing: 0.1,
      );

  // ==================== 工具方法 ====================

  /// 根据颜色创建文本样式
  /// [baseStyle] 基础样式，[color] 文本颜色
  static TextStyle withColor(TextStyle baseStyle, Color color) {
    return baseStyle.copyWith(color: color);
  }

  /// 根据字体大小创建文本样式
  /// [baseStyle] 基础样式，[fontSize] 字体大小
  static TextStyle withSize(TextStyle baseStyle, double fontSize) {
    return baseStyle.copyWith(fontSize: fontSize);
  }

  /// 根据字体粗细创建文本样式
  /// [baseStyle] 基础样式，[fontWeight] 字体粗细
  static TextStyle withWeight(TextStyle baseStyle, FontWeight fontWeight) {
    return baseStyle.copyWith(fontWeight: fontWeight);
  }

  /// 根据行高创建文本样式
  /// [baseStyle] 基础样式，[height] 行高
  static TextStyle withHeight(TextStyle baseStyle, double height) {
    return baseStyle.copyWith(height: height);
  }
}
