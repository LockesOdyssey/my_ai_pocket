# ScreenUtil 屏幕适配使用说明

## 简介

`flutter_screenutil` 提供了便捷的屏幕适配方法，可以根据设计稿尺寸自动适配不同屏幕。

## 设计稿尺寸

当前配置的设计稿尺寸为：**375 x 812**（iPhone X 标准尺寸）

如果需要修改，请在 `lib/main.dart` 中修改 `designSize` 参数。

## 基本用法

### 1. 宽度适配 `.w`

根据屏幕宽度比例设置值：

```dart
// 设置宽度为设计稿中的 16px
Container(
  width: 16.w,
  height: 50.h,
)

// 设置内边距
Padding(
  padding: EdgeInsets.all(16.w),
  child: Text('Hello'),
)
```

### 2. 高度适配 `.h`

根据屏幕高度比例设置值：

```dart
// 设置高度为设计稿中的 50px
Container(
  width: 100.w,
  height: 50.h,
)

// 设置外边距
SizedBox(height: 20.h)
```

### 3. 字体大小适配 `.sp`

根据屏幕宽度适配字体大小：

```dart
Text(
  'Hello World',
  style: TextStyle(fontSize: 16.sp),
)

// 或者使用
Text(
  'Hello World',
  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
)
```

### 4. 圆角/半径适配 `.r`

根据屏幕较小边适配圆角：

```dart
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.r),
  ),
)

// 圆形头像
CircleAvatar(
  radius: 25.r,
)
```

## 完整示例

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('示例页面'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // 16px 的内边距
        child: Column(
          children: [
            // 标题
            Text(
              '标题',
              style: TextStyle(
                fontSize: 20.sp, // 20px 的字体
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h), // 12px 的间距
            
            // 卡片
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r), // 12px 的圆角
              ),
              child: Text(
                '内容',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 获取屏幕信息

```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 获取屏幕宽度
double screenWidth = 1.sw; // 等同于 ScreenUtil().screenWidth

// 获取屏幕高度
double screenHeight = 1.sh; // 等同于 ScreenUtil().screenHeight

// 获取状态栏高度
double statusBarHeight = ScreenUtil().statusBarHeight;

// 获取底部安全区域高度
double bottomBarHeight = ScreenUtil().bottomBarHeight;
```

## 注意事项

1. **设计稿尺寸**：默认使用 375x812（iPhone X），如果你的设计稿是其他尺寸，需要修改 `designSize`
2. **字体适配**：`.sp` 会根据屏幕宽度适配，确保文字在不同屏幕上显示一致
3. **圆角适配**：`.r` 会根据屏幕较小边适配，适合用于圆角、圆形等
4. **组合使用**：可以同时使用 `.w`、`.h`、`.sp`、`.r` 来适配不同属性

## 修改设计稿尺寸

如果需要修改设计稿尺寸，在 `lib/main.dart` 中修改：

```dart
ScreenUtilInit(
  designSize: const Size(375, 812), // 修改为你设计稿的尺寸
  // ...
)
```

常见设计稿尺寸：
- iPhone X: 375 x 812
- iPhone 8: 375 x 667
- Android 标准: 360 x 640
- iPad: 768 x 1024
