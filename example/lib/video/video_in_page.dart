import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/video/draw_video_page.dart';
import 'package:flutter_pangrowth_example/video/grid_video_page.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/14 12:14 下午
/// @Email gstory0404@gmail.com
/// @Description: Draw沉浸式短视频

class VideoInPage extends StatefulWidget {
  const VideoInPage({Key? key}) : super(key: key);

  @override
  _VideoInPageState createState() => _VideoInPageState();
}

class _VideoInPageState extends State<VideoInPage> {
  int _currentIndex = 0;

  List<Widget> _pageList = [
    DrawVideoPage(),
    GridVideoPage(),
  ];

  final List<BottomNavigationBarItem> _barItem = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: '沉浸小视频'),
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: '宫格小视频'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter页面中插入视频新闻界面"),
      ),
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        currentIndex: this._currentIndex,
        items: _barItem,
        fixedColor: Colors.pink,
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
