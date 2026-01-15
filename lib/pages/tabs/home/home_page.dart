import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

/// 首页
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  HomeController get controller => Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home'.tr)),
      body: const Center(child: Text('首页内容待开发')),
    );
  }
}
