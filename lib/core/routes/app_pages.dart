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
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: BindingsBuilder(() {
        // 使用 put 而不是 lazyPut，确保控制器立即创建并触发 onReady
        Get.put<SplashController>(SplashController());
      }),
    ),
    
    // 主页面（带TabBar）
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
      binding: BindingsBuilder(() {
        // 先注册子页面控制器（使用 put 确保立即创建，因为 MainController 会立即使用它们）
        if (!Get.isRegistered<HomeController>()) {
          Get.put<HomeController>(HomeController(), permanent: false);
        }
        if (!Get.isRegistered<SettingsController>()) {
          Get.put<SettingsController>(SettingsController(), permanent: false);
        }
        // 然后注册 MainController
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
