import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';

/// 启动页控制器
class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    _navigateToMain();
  }

  /// 跳转到主页面
  Future<void> _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(AppRoutes.main);
  }
}
