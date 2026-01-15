import 'package:get/get.dart';
import 'app_routes.dart';
import '../../pages/splash/splash_page.dart';
import '../../pages/splash/splash_controller.dart';
import '../../pages/main/main_page.dart';
import '../../pages/main/main_controller.dart';
import '../../pages/tabs/home/home_page.dart';
import '../../pages/tabs/home/home_controller.dart';
import '../../pages/tabs/settings/settings_page.dart';
import '../../pages/tabs/settings/settings_controller.dart';

/// 应用路由页面配置
class AppPages {
  static final List<GetPage> routes = [
    // 启动页
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    
    // 主页面（带TabBar）
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MainController>(() => MainController());
      }),
    ),
    
    // 首页
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
    
    // 设置页
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SettingsController>(() => SettingsController());
      }),
    ),
  ];
}
