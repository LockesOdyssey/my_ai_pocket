# GetX 国际化使用说明

## 翻译文件位置

翻译字符串按语言分别配置在以下文件中：

- **简体中文**: `lib/core/translations/app_translations_zh.dart`
- **英文**: `lib/core/translations/app_translations_en.dart`
- **繁体中文**: `lib/core/translations/app_translations_zh_hant.dart`

主翻译类：`lib/core/translations/app_translations.dart`（整合所有语言）

## 如何使用 `.tr` 扩展方法

### 基本用法

```dart
// 直接使用字符串的 .tr 扩展方法
Text('appName'.tr)
Text('welcome'.tr)
Text('addTransaction'.tr)
```

### 带参数（如果需要）

```dart
// 如果翻译字符串需要参数，可以使用 GetX 的参数语法
// 例如：'hello'.trParams({'name': 'John'})
// 但需要在翻译文件中定义占位符
```

## 如何添加新的翻译字符串

1. 在对应的语言文件中添加新的键值对：

**简体中文** (`app_translations_zh.dart`):
```dart
'appKey': '应用键',
```

**英文** (`app_translations_en.dart`):
```dart
'appKey': 'App Key',
```

**繁体中文** (`app_translations_zh_hant.dart`):
```dart
'appKey': '應用鍵',
```

2. 在代码中使用：

```dart
Text('appKey'.tr)
```

**注意**：确保在所有三个语言文件中都添加了对应的翻译，否则会显示键名本身。

## 切换语言

```dart
// 切换到简体中文
Get.updateLocale(const Locale('zh'));

// 切换到英文
Get.updateLocale(const Locale('en'));

// 切换到繁体中文
Get.updateLocale(const Locale('zh', 'Hant'));
```

## 获取当前语言

```dart
// 获取当前语言代码
String currentLang = Get.locale?.languageCode ?? 'zh';

// 判断当前语言
if (Get.locale?.languageCode == 'zh') {
  // 中文逻辑
}
```

## 注意事项

- 键名使用小写字母和下划线（snake_case）或驼峰命名（camelCase）都可以
- 确保所有语言文件中都有对应的翻译，否则会显示键名本身
- 修改翻译后需要热重启应用才能看到效果
