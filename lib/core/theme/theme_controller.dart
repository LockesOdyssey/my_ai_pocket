import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_colors.dart';
import 'theme_state.dart';
import '../database/app_database.dart';
import '../database/services/user_config_service.dart';

/// 主题管理控制器
class ThemeController extends GetxController {
  final ThemeState state = ThemeState();
  UserConfigService? _userConfigService;

  /// 切换主题模式
  void toggleTheme() {
    switch (state.themeMode.value) {
      case AppThemeMode.light:
        state.themeMode.value = AppThemeMode.dark;
        break;
      case AppThemeMode.dark:
        state.themeMode.value = AppThemeMode.light;
        break;
      case AppThemeMode.system:
        // 如果当前是跟随系统，切换到浅色模式
        state.themeMode.value = AppThemeMode.light;
        break;
    }
    _updateTheme();
  }

  /// 设置主题模式
  void setThemeMode(AppThemeMode mode) {
    state.themeMode.value = mode;
    _updateTheme();
  }

  /// 设置为浅色模式
  void setLightMode() {
    setThemeMode(AppThemeMode.light);
  }

  /// 设置为深色模式
  void setDarkMode() {
    setThemeMode(AppThemeMode.dark);
  }

  /// 设置为跟随系统
  void setSystemMode() {
    setThemeMode(AppThemeMode.system);
  }

  /// 获取当前主题数据
  ThemeData get lightTheme => _buildLightTheme();
  ThemeData get darkTheme => _buildDarkTheme();

  /// 获取当前主题模式（用于 MaterialApp，返回 Flutter 的 ThemeMode）
  ThemeMode get themeMode {
    switch (state.themeMode.value) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  /// 更新主题（通过 Obx 自动响应，此方法保留用于未来扩展）
  void _updateTheme() {
    // 主题变化会通过 Obx 自动响应，这里可以添加其他逻辑
    // 保存配置到数据库
    _saveThemeConfig();
  }

  /// 保存主题配置到数据库
  void _saveThemeConfig() {
    try {
      if (_userConfigService == null) {
        final database = Get.find<AppDatabase>();
        _userConfigService = UserConfigService(database);
      }
      _userConfigService?.saveUserConfig(themeMode: state.themeMode.value);
    } catch (e) {
      // 忽略错误，避免影响应用运行
      print('保存主题配置失败: $e');
    }
  }

  /// 构建浅色主题
  ThemeData _buildLightTheme() {
    final colors = AppColors.light;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        secondary: colors.accent,
        surface: colors.surface,
        error: colors.error,
        onPrimary: Colors.white,
        onSecondary: colors.textPrimary,
        onSurface: colors.textPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: colors.background,
      cardColor: colors.card,
      dividerColor: colors.divider,
      textTheme: TextTheme(
        displayLarge: TextStyle(color: colors.textPrimary),
        displayMedium: TextStyle(color: colors.textPrimary),
        displaySmall: TextStyle(color: colors.textPrimary),
        headlineLarge: TextStyle(color: colors.textPrimary),
        headlineMedium: TextStyle(color: colors.textPrimary),
        headlineSmall: TextStyle(color: colors.textPrimary),
        titleLarge: TextStyle(color: colors.textPrimary),
        titleMedium: TextStyle(color: colors.textPrimary),
        titleSmall: TextStyle(color: colors.textPrimary),
        bodyLarge: TextStyle(color: colors.textPrimary),
        bodyMedium: TextStyle(color: colors.textPrimary),
        bodySmall: TextStyle(color: colors.textSecondary),
        labelLarge: TextStyle(color: colors.textPrimary),
        labelMedium: TextStyle(color: colors.textSecondary),
        labelSmall: TextStyle(color: colors.textTertiary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: colors.card,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.background,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textSecondary,
        selectedLabelStyle: TextStyle(color: colors.primary),
        unselectedLabelStyle: TextStyle(color: colors.textSecondary),
      ),
    );
  }

  /// 构建深色主题
  ThemeData _buildDarkTheme() {
    final colors = AppColors.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        secondary: colors.accent,
        surface: colors.surface,
        error: colors.error,
        onPrimary: Colors.white,
        onSecondary: colors.textPrimary,
        onSurface: colors.textPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: colors.background,
      cardColor: colors.card,
      dividerColor: colors.divider,
      textTheme: TextTheme(
        displayLarge: TextStyle(color: colors.textPrimary),
        displayMedium: TextStyle(color: colors.textPrimary),
        displaySmall: TextStyle(color: colors.textPrimary),
        headlineLarge: TextStyle(color: colors.textPrimary),
        headlineMedium: TextStyle(color: colors.textPrimary),
        headlineSmall: TextStyle(color: colors.textPrimary),
        titleLarge: TextStyle(color: colors.textPrimary),
        titleMedium: TextStyle(color: colors.textPrimary),
        titleSmall: TextStyle(color: colors.textPrimary),
        bodyLarge: TextStyle(color: colors.textPrimary),
        bodyMedium: TextStyle(color: colors.textPrimary),
        bodySmall: TextStyle(color: colors.textSecondary),
        labelLarge: TextStyle(color: colors.textPrimary),
        labelMedium: TextStyle(color: colors.textSecondary),
        labelSmall: TextStyle(color: colors.textTertiary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: colors.card,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.background,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textSecondary,
        selectedLabelStyle: TextStyle(color: colors.primary),
        unselectedLabelStyle: TextStyle(color: colors.textSecondary),
      ),
    );
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
    // 主题会在 main.dart 中通过 Obx 响应变化，这里不需要手动更新
  }
}
