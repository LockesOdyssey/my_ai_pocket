import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_state.dart';
import '../tabs/home/home_page.dart';
import '../tabs/settings/settings_page.dart';
import '../tabs/statistics/statistics_page.dart';

/// 主页面控制器
class MainController extends GetxController {
  final MainState state = MainState();

  // 页面列表
  final List<Widget> pages = [
    const HomePage(),
    const StatisticsPage(),
    const SettingsPage(),
  ];

  /// 切换 tab
  void switchTab(int index) {
    state.currentIndex.value = index;
  }
}
