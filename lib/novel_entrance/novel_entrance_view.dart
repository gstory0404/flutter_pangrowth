import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/7 2:05 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class NovelEntranceView extends StatefulWidget {
  final double viewWidth;
  final double viewHeight;
  final String type;
  final String style;

  const NovelEntranceView(
      {Key? key,
      required this.viewWidth,
      required this.viewHeight,
      required this.type,
        required this.style})
      : super(key: key);

  @override
  _NovelEntranceViewState createState() => _NovelEntranceViewState();
}

class _NovelEntranceViewState extends State<NovelEntranceView> {

  String _viewType = "com.gstory.flutter_pangrowth/NovelEntranceView";

  MethodChannel? _channel;

  //广告是否显示
  bool _isShow = true;

  @override
  void initState() {
    super.initState();
    // _isShow = true;
    // setState(() {
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    // if (!_isShow) {
    //   return Container();
    // }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        width: widget.viewWidth,
        height: widget.viewHeight,
        child: AndroidView(
          viewType: _viewType,
          creationParams: {
            "viewWidth": widget.viewWidth,
            "viewHeight": widget.viewHeight,
            "type": widget.type,
            "style": widget.style,
          },
          onPlatformViewCreated: _registerChannel,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return SizedBox(
        width: widget.viewWidth,
        height: widget.viewHeight,
        child: UiKitView(
          viewType: _viewType,
          creationParams: {
            "viewWidth": widget.viewWidth,
            "viewHeight": widget.viewHeight,
            "type": widget.type,
            "style": widget.style,
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
    }
  }
}
