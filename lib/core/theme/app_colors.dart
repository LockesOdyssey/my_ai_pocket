import 'package:flutter/material.dart';

/// 应用颜色定义
class AppColors {
  AppColors._();

  // 应用配色
  static const Color colorF9B240 = Color(0xFFF9B240); // 橙黄色 - 主题色
  static const Color color9FAD40 = Color(0xFF9FAD40); // 黄绿色
  static const Color color509C5D = Color(0xFF509C5D); // 绿色
  static const Color color008272 = Color(0xFF008272); // 青绿色
  static const Color color066571 = Color(0xFF066571); // 深青绿色
  static const Color color2F4858 = Color(0xFF2F4858); // 深蓝灰色

  // 主题色（选择 #F9B240 作为主主题色）
  static const Color primary = colorF9B240;

  // 浅色模式颜色
  static const LightColors light = LightColors();

  // 深色模式颜色
  static const DarkColors dark = DarkColors();
}

/// 浅色模式颜色方案
class LightColors {
  const LightColors();

  // 背景色
  Color get background => const Color(0xFFFFFFFF); // 白色背景
  Color get surface => const Color(0xFFF5F5F5); // 浅灰表面
  Color get card => const Color(0xFFFFFFFF); // 卡片背景

  // 文字颜色
  Color get textPrimary => const Color(0xFF1A1A1A); // 主要文字（深灰黑）
  Color get textSecondary => const Color(0xFF666666); // 次要文字（中灰）
  Color get textTertiary => const Color(0xFF999999); // 三级文字（浅灰）

  // 主题色
  Color get primary => AppColors.primary; // #F9B240
  Color get primaryLight => const Color(0xFFFFC966); // 主题色浅色变体
  Color get primaryDark => const Color(0xFFD89A2E); // 主题色深色变体

  // 功能色
  Color get success => AppColors.color509C5D; // #509C5D 成功色（绿色）
  Color get warning => AppColors.colorF9B240; // #F9B240 警告色（使用主题色）
  Color get error => const Color(0xFFE53935); // 错误色（红色）
  Color get info => AppColors.color008272; // #008272 信息色（青绿色）

  // 辅助色
  Color get accent => AppColors.color9FAD40; // #9FAD40 强调色（黄绿色）
  Color get divider => const Color(0xFFE0E0E0); // 分割线颜色
  Color get border => const Color(0xFFE0E0E0); // 边框颜色

  // 阴影
  Color get shadow => const Color(0x1A000000); // 阴影颜色
}

/// 深色模式颜色方案
class DarkColors {
  const DarkColors();

  // 背景色（偏橙色系）
  Color get background => const Color(0xFF2A1F15); // 深棕色背景（偏橙色）
  Color get surface => const Color(0xFF3D2E1F); // 深棕色表面（偏橙色）
  Color get card => const Color(0xFF4D3E2F); // 卡片背景（稍浅的深棕色，偏橙色）

  // 文字颜色
  Color get textPrimary => const Color(0xFFFFFFFF); // 主要文字（白色）
  Color get textSecondary => const Color(0xFFB0B0B0); // 次要文字（浅灰）
  Color get textTertiary => const Color(0xFF808080); // 三级文字（中灰）

  // 主题色
  Color get primary => AppColors.primary; // #F9B240
  Color get primaryLight => const Color(0xFFFFD580); // 主题色浅色变体（深色模式下更亮）
  Color get primaryDark => const Color(0xFFD89A2E); // 主题色深色变体

  // 功能色
  Color get success => AppColors.color509C5D; // #509C5D 成功色（绿色）
  Color get warning => AppColors.colorF9B240; // #F9B240 警告色（使用主题色）
  Color get error => const Color(0xFFEF5350); // 错误色（亮红色）
  Color get info => AppColors.color008272; // #008272 信息色（青绿色）

  // 辅助色
  Color get accent => AppColors.color9FAD40; // #9FAD40 强调色（黄绿色）
  Color get divider => const Color(0xFF3D2E1F); // 分割线颜色（深棕色，偏橙色）
  Color get border => const Color(0xFF3D2E1F); // 边框颜色（深棕色，偏橙色）

  // 阴影
  Color get shadow => const Color(0x40000000); // 阴影颜色（深色模式下更明显）
}
