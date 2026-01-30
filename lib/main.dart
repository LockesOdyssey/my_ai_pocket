import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/translations/app_translations.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/theme_controller.dart';
import 'core/language/language_controller.dart';
import 'core/database/app_database.dart';
import 'core/database/services/user_config_service.dart';
import 'core/database/services/bill_service.dart';
import 'core/database/services/category_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化数据库（使用 permanent: true 确保数据库实例在整个应用生命周期中保持）
  final database = AppDatabase();
  Get.put(database, permanent: true);
  
  // 初始化数据库服务类
  Get.put(BillService(database), permanent: true);
  Get.put(CategoryService(database), permanent: true);
  Get.put(UserConfigService(database), permanent: true);
  
  // 初始化主题控制器
  final themeController = ThemeController();
  Get.put(themeController, permanent: true);
  
  // 初始化语言控制器
  final languageController = LanguageController();
  Get.put(languageController, permanent: true);
  
  // 加载用户配置
  final userConfigService = Get.find<UserConfigService>();
  await userConfigService.loadUserConfig(
    themeController: themeController,
    languageController: languageController,
  );
  
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
      
      // ScreenUtil 初始化
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812), // 设计稿尺寸（iPhone X 标准尺寸）
          minTextAdapt: true, // 是否根据宽度/高度中的最小值适配文字
          splitScreenMode: true, // 支持分屏尺寸
          child: child!,
        );
      },
    ));
  }
}
