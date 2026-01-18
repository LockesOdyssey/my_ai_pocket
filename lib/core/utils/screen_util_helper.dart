import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ScreenUtil 辅助工具类
/// 提供便捷的屏幕适配方法
class ScreenUtilHelper {
  ScreenUtilHelper._();

  /// 根据宽度比例设置值
  /// 例如：16.w 表示设计稿中 16px 在当前屏幕上的宽度
  static double width(double width) => width.w;

  /// 根据高度比例设置值
  /// 例如：12.h 表示设计稿中 12px 在当前屏幕上的高度
  static double height(double height) => height.h;

  /// 根据宽度或高度中的较小值设置值
  /// 例如：10.r 会根据屏幕较小边进行适配
  static double radius(double radius) => radius.r;

  /// 设置字体大小（会根据屏幕宽度适配）
  /// 例如：14.sp 表示设计稿中 14px 的字体大小
  static double fontSize(double fontSize) => fontSize.sp;

  /// 获取屏幕宽度
  static double get screenWidth => 1.sw;

  /// 获取屏幕高度
  static double get screenHeight => 1.sh;

  /// 获取状态栏高度
  static double get statusBarHeight => ScreenUtil().statusBarHeight;

  /// 获取底部安全区域高度
  static double get bottomBarHeight => ScreenUtil().bottomBarHeight;
}
