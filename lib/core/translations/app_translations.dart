import 'package:get/get.dart';
import 'app_translations_zh.dart';
import 'app_translations_en.dart';
import 'app_translations_zh_hant.dart';

/// GetX 国际化翻译类
/// 整合所有语言的翻译文件
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh': AppTranslationsZh.translations, // 简体中文
        'en': AppTranslationsEn.translations, // 英文
        'zh_Hant': AppTranslationsZhHant.translations, // 繁体中文
      };
}
