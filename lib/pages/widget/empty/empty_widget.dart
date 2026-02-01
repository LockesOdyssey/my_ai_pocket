///
///  Created by shaofengluo on 2026/1/30.
///  Copyright © 2026 leelen. All rights reserved.
///

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_ai_pocket/core/theme/theme_helper.dart';

/// 空视图组件
/// 用于在列表没有数据时显示空状态
class EmptyWidget extends StatelessWidget {
  /// 图标
  final IconData icon;
  
  /// 文字描述
  final String text;
  
  /// 图标大小
  final double? iconSize;
  
  /// 图标颜色
  final Color? iconColor;
  
  /// 文字样式
  final TextStyle? textStyle;
  
  /// 是否显示在中心
  final bool center;
  
  /// 自定义子组件（可选，用于添加按钮等）
  final Widget? child;

  const EmptyWidget({
    super.key,
    required this.icon,
    required this.text,
    this.iconSize,
    this.iconColor,
    this.textStyle,
    this.center = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: iconSize ?? 64.sp,
          color: iconColor ?? ThemeHelper.textTertiaryColor,
        ),
        SizedBox(height: 16.h),
        Text(
          text,
          style: textStyle ?? TextStyle(
            fontSize: 16.sp,
            color: ThemeHelper.textSecondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        if (child != null) ...[
          SizedBox(height: 24.h),
          child!,
        ],
      ],
    );

    if (center) {
      return Center(child: content);
    }

    return content;
  }
}