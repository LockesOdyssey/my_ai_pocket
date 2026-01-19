import 'package:flutter/material.dart';

/// 图标工具类
class IconHelper {
  /// 根据图标名称获取 Material Icons
  /// 如果找不到对应的图标，返回默认图标
  static IconData getIconData(String? iconName, {IconData defaultIcon = Icons.category}) {
    if (iconName == null || iconName.isEmpty) {
      return defaultIcon;
    }

    // 使用反射获取 Icons 类的静态属性
    // 由于 Dart 不支持运行时反射，我们需要手动映射
    final iconMap = _getIconMap();
    return iconMap[iconName] ?? defaultIcon;
  }

  /// 获取图标映射表
  static Map<String, IconData> _getIconMap() {
    return {
      'restaurant': Icons.restaurant,
      'directions_car': Icons.directions_car,
      'shopping_cart': Icons.shopping_cart,
      'movie': Icons.movie,
      'local_hospital': Icons.local_hospital,
      'school': Icons.school,
      'home': Icons.home,
      'phone': Icons.phone,
      'flash_on': Icons.flash_on,
      'more_horiz': Icons.more_horiz,
      'account_balance_wallet': Icons.account_balance_wallet,
      'card_giftcard': Icons.card_giftcard,
      'trending_up': Icons.trending_up,
      'work': Icons.work,
      'savings': Icons.savings,
      'redeem': Icons.redeem,
      'assignment_return': Icons.assignment_return,
    };
  }

  /// 将十六进制颜色字符串转换为 Color
  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
