import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @Author: gstory
/// @CreateDate: 2023/10/10 15:02
/// @Email gstory0404@gmail.com
/// @Description: 短剧卡片

class PlayletCardView extends StatefulWidget {
  final double width;
  final double height;
  bool? autoPlay;
  bool? loop;
  bool? mute;

  ///# 短剧卡片
  ///- [width] 宽 (根据宽返回 高:宽`为`16:9` 的视频，加载完成后flutter widget会自动适配原生返回视频大小，这里高度可能会与设置的height不一致)
  ///- [height] 高
  ///- [autoPlay] 是否自动播放，默认true
  ///- [loop] 是否是否循环播放播放，默认true
  ///- [mute] 是否静音，默认true
  PlayletCardView(
      {Key? key,
      required this.width,
      required this.height,
      this.autoPlay,
      this.loop,
      this.mute})
      : super(key: key);

  @override
  State<PlayletCardView> createState() => _PlayletCardViewState();
}

class _PlayletCardViewState extends State<PlayletCardView> {
  final String _viewType = "com.gstory.flutter_pangrowth/PlayletCardView";

  MethodChannel? _channel;

  double _width = 0;
  double _height = 0;

  @override
  void initState() {
    super.initState();
    _width = widget.width.toDouble();
    _height = widget.width.toDouble();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Container();
      // return SizedBox(
      //   width: widget.width,
      //   height: widget.height,
      //   child: AndroidView(
      //     viewType: _viewType,
      //     creationParams: {
      //       "width": widget.width,
      //       "height": widget.height,
      //     },
      //     onPlatformViewCreated: _registerChannel,
      //     creationParamsCodec: const StandardMessageCodec(),
      //   ),
      // );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return SizedBox(
        width: _width,
        height: _height,
        child: UiKitView(
          viewType: _viewType,
          creationParams: {
            "width": _width,
            "height": _height,
            "autoPlay": widget.autoPlay,
            "loop": widget.loop,
            "mute": widget.mute,
          },
          onPlatformViewCreated: _registerChannel,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else {
      return Container();
    }
  }

  //注册cannel
  void _registerChannel(int id) {
    _channel = MethodChannel("${_viewType}_$id");
    _channel?.setMethodCallHandler(_platformCallHandler);
  }

  //监听原生view传值
  Future<dynamic> _platformCallHandler(MethodCall call) async {
    switch (call.method) {
      //显示广告
      case "onShow":
        Map map = call.arguments;
        print(map);
        if (mounted) {
          setState(() {
            _width = map["width"];
            _height = map["height"];
          });
        }
        break;
    }
  }
}
