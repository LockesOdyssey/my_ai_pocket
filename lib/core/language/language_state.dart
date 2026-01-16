import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 语言代码枚举
enum AppLanguage {
  zh,      // 简体中文
  zhHant,  // 繁体中文
  en,      // 英文
}

/// 语言状态
class LanguageState {
  // 当前语言
  final Rx<AppLanguage> currentLanguage;

  LanguageState() : currentLanguage = AppLanguage.zh.obs;

  /// 获取语言代码字符串
  String get languageCode {
    switch (currentLanguage.value) {
      case AppLanguage.zh:
        return 'zh_CN';
      case AppLanguage.zhHant:
        return 'zh_TW';
      case AppLanguage.en:
        return 'en_US';
    }
  }

  /// 获取 Locale 对象
  Locale get locale {
    switch (currentLanguage.value) {
      case AppLanguage.zh:
        return const Locale('zh', 'CN'); // 简体中文
      case AppLanguage.zhHant:
        return const Locale('zh', 'TW'); // 繁体中文
      case AppLanguage.en:
        return const Locale('en', 'US'); // 英文
    }
  }
}
