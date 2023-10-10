### 一、[官方文档](https://www.csjplatform.com/union/media/union/download/detail?id=81&osType=android)

### 二、插件配置
1、在android/build.gradle文件中
```
allprojects {
    repositories {
        google()
        mavenCentral()
        //火山引擎maven仓库地址
        maven{url 'https://artifact.bytedance.com/repository/Volcengine/'}
        //穿山甲maven仓库地址
        maven{url 'https://artifact.bytedance.com/repository/pangle'}
    }
}

```

2、在android/app/src/main/AndroidManifest.xml文件

```dart
<manifest ···
  xmlns:tools="http://schemas.android.com/tools"
 ···>
 
<!--必要权限-->
<uses-permission android:name="android.permission.INTERNET" />

<!--可选权限 缓存小说书籍到本地-->
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

<application
 ···
  tools:replace="android:label"
 ···>
```

3、在android/app/src/main下新建assets文件，把下载的json文件改名pangrowthconfig.json导入

4、在android/app/build.gradle 修改

```
defaultConfig {
       ···
        minSdkVersion 21
        ···
    }
```

5、 在android/app/build.gradle添加命令依赖gradle脚本：
```dart
apply from: 'https://sf3-fe-tos.pglstatp-toutiao.com/obj/pangle-empower/android/pangrowth_media/plugin_config.gradle'
```

6、依赖管理
内容输出sdk支持安卓版本：21~29
依赖安卓内部库：support-v4，建议版本：24以上
依赖安卓内部库：recyclerview-v7，建议版本：24以上
依赖安卓内部库：constraint-layout，指定版本：1.1.2，具体方式如下(androidx和support根据具体使用环境使用其中一个即可)：
```dart
configurations.all {
    resolutionStrategy {
        // support的用这个
        force 'com.android.support.constraint:constraint-layout:1.1.2'
        // androidx包用这个
        force 'androidx.constraintlayout:constraintlayout:1.1.2'
    }
}
```

7、打包安装运行失败
当debug运行正常，打包后运行失败，可以尝试将混淆关闭再进行打包
```dart
minifyEnabled false
shrinkResources false
zipAlignEnabled true
```

