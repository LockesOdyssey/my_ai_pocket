import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_controller.dart';

/// 设置页面
class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  SettingsController get controller => Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: Obx(() => ListView(
        children: [
          // 切换语言
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('switchLanguage'.tr),
            subtitle: Text(controller.getCurrentLanguageText()),
            trailing: const Icon(Icons.chevron_right),
            onTap: controller.switchLanguage,
          ),
          const Divider(),

          // 切换主题
          ListTile(
            leading: const Icon(Icons.palette),
            title: Text('switchTheme'.tr),
            subtitle: Text(controller.getCurrentThemeText()),
            trailing: const Icon(Icons.chevron_right),
            onTap: controller.switchTheme,
          ),
          const Divider(),

          // 关于
          ListTile(
            leading: const Icon(Icons.info),
            title: Text('about'.tr),
            trailing: const Icon(Icons.chevron_right),
            onTap: controller.showAbout,
          ),
        ],
      )),
    );
  }
}
