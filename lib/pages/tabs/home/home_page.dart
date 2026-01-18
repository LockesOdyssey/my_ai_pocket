import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_ai_pocket/core/theme/theme_helper.dart';
import 'home_controller.dart';
import '../../../core/widgets/draggable_floating_button.dart';

/// 首页
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  HomeController get controller => Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home'.tr)),
      body: Stack(
        children: [
          const Center(child: Text('首页内容待开发')),
          // 固定右下角 Add 按钮（最稳定写法）
          Positioned(
            right: 16.w,
            bottom: 24.h,
            child: FloatingActionButton(
              backgroundColor: ThemeHelper.primaryColor,
              onPressed: () {
                controller.addBillEvent();
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
