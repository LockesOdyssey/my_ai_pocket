import 'package:get/get.dart';

/// 主页面状态
class MainState {
  // 当前选中的 tab 索引
  final RxInt currentIndex;

  MainState() : currentIndex = 0.obs;
}
