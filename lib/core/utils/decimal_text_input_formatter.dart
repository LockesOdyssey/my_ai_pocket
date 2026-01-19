import 'package:flutter/services.dart';

/// 限制小数位数的文本输入格式化器
/// 最多允许两位小数
class DecimalTextInputFormatter extends TextInputFormatter {
  /// 允许的最大小数位数
  final int maxDecimalPlaces;

  DecimalTextInputFormatter({this.maxDecimalPlaces = 2});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 如果新值为空，允许
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 如果新值只包含数字和小数点，检查格式
    final regex = RegExp(r'^\d*\.?\d*$');
    if (!regex.hasMatch(newValue.text)) {
      return oldValue; // 不允许非数字字符（除了小数点）
    }

    // 检查小数点数量
    final dotCount = '.'.allMatches(newValue.text).length;
    if (dotCount > 1) {
      return oldValue; // 不允许多个小数点
    }

    // 如果包含小数点，检查小数位数
    if (newValue.text.contains('.')) {
      final parts = newValue.text.split('.');
      if (parts.length == 2 && parts[1].length > maxDecimalPlaces) {
        // 如果小数位数超过限制，截断
        final truncated =
            '${parts[0]}.${parts[1].substring(0, maxDecimalPlaces)}';
        return TextEditingValue(
          text: truncated,
          selection: TextSelection.collapsed(offset: truncated.length),
        );
      }
    }

    return newValue;
  }
}
