import 'package:get/get.dart';
import 'app_translations_zh.dart';
import 'app_translations_en.dart';
import 'app_translations_zh_hant.dart';

/// GetX 国际化翻译类
/// 整合所有语言的翻译文件
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': AppTranslationsZh.translations, // 简体中文
        'zh_TW': AppTranslationsZhHant.translations, // 繁体中文
        'en_US': AppTranslationsEn.translations, // 英文
        // 兼容性：也支持不带国家代码的格式
        'zh': AppTranslationsZh.translations,
        'en': AppTranslationsEn.translations,
      };
}
