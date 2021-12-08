### [官方文档](https://www.csjplatform.com/union/media/union/download/detail?id=81&osType=android)

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