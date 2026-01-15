import 'package:flutter/material.dart';

/// 应用颜色定义
class AppColors {
  AppColors._();

  // 用户提供的颜色
  static const Color color0B1C2D = Color(0xFF0B1C2D); // 深蓝黑色
  static const Color color00475D = Color(0xFF00475D); // 深青色
  static const Color color00767D = Color(0xFF00767D); // 青绿色 - 选为主题色
  static const Color color0DA785 = Color(0xFF0DA785); // 绿色
  static const Color color88D479 = Color(0xFF88D479); // 浅绿色
  static const Color colorF9F871 = Color(0xFFF9F871); // 浅黄色

  // 主题色（选择 #00767D 作为主主题色）
  static const Color primary = color00767D;

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
  Color get primary => AppColors.primary; // #00767D
  Color get primaryLight => const Color(0xFF00A8B5); // 主题色浅色变体
  Color get primaryDark => const Color(0xFF005A66); // 主题色深色变体

  // 功能色
  Color get success => AppColors.color0DA785; // #0DA785 成功色
  Color get warning => AppColors.colorF9F871; // #F9F871 警告色
  Color get error => const Color(0xFFE53935); // 错误色（红色）
  Color get info => AppColors.color00767D; // 信息色（使用主题色）

  // 辅助色
  Color get accent => AppColors.color88D479; // #88D479 强调色
  Color get divider => const Color(0xFFE0E0E0); // 分割线颜色
  Color get border => const Color(0xFFE0E0E0); // 边框颜色

  // 阴影
  Color get shadow => const Color(0x1A000000); // 阴影颜色
}

/// 深色模式颜色方案
class DarkColors {
  const DarkColors();

  // 背景色
  Color get background => AppColors.color0B1C2D; // #0B1C2D 深蓝黑背景
  Color get surface => AppColors.color00475D; // #00475D 深青色表面
  Color get card => const Color(0xFF1A2B3D); // 卡片背景（稍浅的深色）

  // 文字颜色
  Color get textPrimary => const Color(0xFFFFFFFF); // 主要文字（白色）
  Color get textSecondary => const Color(0xFFB0B0B0); // 次要文字（浅灰）
  Color get textTertiary => const Color(0xFF808080); // 三级文字（中灰）

  // 主题色
  Color get primary => AppColors.primary; // #00767D
  Color get primaryLight => const Color(0xFF00B8C5); // 主题色浅色变体（深色模式下更亮）
  Color get primaryDark => const Color(0xFF005A66); // 主题色深色变体

  // 功能色
  Color get success => AppColors.color0DA785; // #0DA785 成功色
  Color get warning => AppColors.colorF9F871; // #F9F871 警告色
  Color get error => const Color(0xFFEF5350); // 错误色（亮红色）
  Color get info => AppColors.color00767D; // 信息色（使用主题色）

  // 辅助色
  Color get accent => AppColors.color88D479; // #88D479 强调色
  Color get divider => const Color(0xFF2A3A4A); // 分割线颜色（深色）
  Color get border => const Color(0xFF2A3A4A); // 边框颜色（深色）

  // 阴影
  Color get shadow => const Color(0x40000000); // 阴影颜色（深色模式下更明显）
}
