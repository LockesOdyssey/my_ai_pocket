import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ai_pocket/core/theme/app_text_styles.dart';
import 'package:my_ai_pocket/core/theme/theme_helper.dart';
import 'package:my_ai_pocket/core/theme/app_colors.dart';
import 'settings_controller.dart';

/// 设置页面
class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  SettingsController get controller => Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    // 使用全局文本样式，并调整为三级文字颜色（与底部 tab 保持一致）
    final titleStyle = AppTextStyles.withColor(
      AppTextStyles.bodyMedium,
      ThemeHelper.textTertiaryColor,
    );
    final subtitleStyle = AppTextStyles.withColor(
      AppTextStyles.bodySmall,
      ThemeHelper.textTertiaryColor,
    );
    final iconColor = ThemeHelper.textTertiaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: Obx(() => ListView(
        children: [
          // 切换语言
          ListTile(
            leading: Icon(Icons.language, color: iconColor),
            title: Text(
              'switchLanguage'.tr,
              style: titleStyle,
            ),
            subtitle: Text(
              controller.getCurrentLanguageText(),
              style: subtitleStyle,
            ),
            trailing: Icon(Icons.chevron_right, color: iconColor),
            onTap: controller.switchLanguage,
          ),
          Divider(color: ThemeHelper.dividerColor,),

          // 切换主题
          ListTile(
            leading: Icon(Icons.palette, color: iconColor),
            title: Text(
              'switchTheme'.tr,
              style: titleStyle,
            ),
            subtitle: Text(
              controller.getCurrentThemeText(),
              style: subtitleStyle,
            ),
            trailing: Icon(Icons.chevron_right, color: iconColor),
            onTap: controller.switchTheme,
          ),
          Divider(color: ThemeHelper.dividerColor,),

          // 关于
          ListTile(
            leading: Icon(Icons.info, color: iconColor),
            title: Text(
              'about'.tr,
              style: titleStyle,
            ),
            trailing: Icon(Icons.chevron_right, color: iconColor),
            onTap: controller.showAbout,
          ),
        ],
      )),
    );
  }
}
