import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/translations/app_translations.dart';
import '../../core/routes/app_pages.dart';
import '../../core/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '我的AI口袋',
      debugShowCheckedModeBanner: false,
      
      // GetX 国际化配置
      translations: AppTranslations(),
      locale: const Locale('zh'), // 默认语言：简体中文
      fallbackLocale: const Locale('zh'), // 回退语言
      
      // 路由配置
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      
      // 主题配置
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
