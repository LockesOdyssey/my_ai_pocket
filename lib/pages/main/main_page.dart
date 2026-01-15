import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_controller.dart';

/// 主页面（带底部TabBar）
class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  MainController get controller => Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.state.currentIndex.value,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.state.currentIndex.value,
          onTap: controller.switchTab,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: 'settings'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
