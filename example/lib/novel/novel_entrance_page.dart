import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/7 2:12 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class NovelEntrancePage extends StatefulWidget {
  const NovelEntrancePage({Key? key}) : super(key: key);

  @override
  _NovelEntrancePageState createState() => _NovelEntrancePageState();
}

class _NovelEntrancePageState extends State<NovelEntrancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("小说入口控件"),
      ),
      body: Container(
        child: Column(
          children: [
            FlutterPangrowth.novelEntranceView(
                viewWidth: 100, viewHeight: 100, type: 0),
          ],
        ),
      ),
    );
  }
}
