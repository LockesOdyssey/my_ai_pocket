import 'package:get/get.dart';
import 'package:my_ai_pocket/core/routes/app_routes.dart';
import 'home_state.dart';

/// 首页控制器
class HomeController extends GetxController {
  final HomeState state = HomeState();

  @override
  void onInit() {
    super.onInit();
    // 初始化逻辑
  }

  @override
  void onReady() {
    super.onReady();
    // 页面准备完成后的逻辑
  }

  @override
  void onClose() {
    // 清理资源
    super.onClose();
  }

  /// 跳转添加账单
  void addBillEvent() {
    Get.toNamed(AppRoutes.addBill);
  }

  // 在这里添加首页的业务逻辑方法
}
