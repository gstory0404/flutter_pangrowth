import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/14 12:10 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class DrawVideoFullView extends StatefulWidget {
  final double viewWidth;
  final double viewHeight;

  const DrawVideoFullView(
      {Key? key,
        required this.viewWidth,
        required this.viewHeight})
      : super(key: key);

  @override
  _DrawVideoFullViewState createState() => _DrawVideoFullViewState();
}

class _DrawVideoFullViewState extends State<DrawVideoFullView> {

  final String _viewType = "com.gstory.flutter_pangrowth/DrawFullView";

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


