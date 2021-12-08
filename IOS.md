### [官方文档](https://www.csjplatform.com/union/media/union/download/detail?id=81&osType=ios)

1、配置pod
在ios/Podfile文件中配置
```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/bytedance/cocoapods_sdk_source_repo.git'
source 'https://github.com/volcengine/volcengine-specs.git'
```
```
target 'Runner' do
    pod 'Pangrowth', '1.6.1.0', :subspecs => [ 'novel' ]
end
```