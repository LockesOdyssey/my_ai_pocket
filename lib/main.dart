import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/translations/app_translations.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/theme_controller.dart';
import 'core/language/language_controller.dart';

void main() {
  // 初始化主题控制器
  Get.put(ThemeController(), permanent: true);
  // 初始化语言控制器
  Get.put(LanguageController(), permanent: true);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final languageController = Get.find<LanguageController>();
    
    return Obx(() => GetMaterialApp(
      title: '我的AI口袋',
      debugShowCheckedModeBanner: false,
      
      // GetX 国际化配置
      translations: AppTranslations(),
      locale: languageController.state.locale,
      fallbackLocale: const Locale('zh', 'CN'), // 回退语言：简体中文
      
      // 路由配置
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      
      // 主题配置
      theme: themeController.lightTheme,
      darkTheme: themeController.darkTheme,
      themeMode: themeController.themeMode,
    ));
  }
}
