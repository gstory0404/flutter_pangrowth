import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/playlet/PlayletCardView.dart';

/// @Author: gstory
/// @CreateDate: 2023/10/10 15:08
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述
class PlayletCardPage extends StatefulWidget {
  const PlayletCardPage({Key? key}) : super(key: key);

  @override
  State<PlayletCardPage> createState() => _PlayletCardPageState();
}

class _PlayletCardPageState extends State<PlayletCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('短剧卡片'),
      ),
      body: Center(
        child: PlayletCardView(
          //宽 (根据宽返回 高:宽`为`16:9` 的视频，加载完成后flutter widget会自动适配原生返回视频大小，这里高度可能会与设置的height不一致)
          width: 400,
          //高
          height: 200,
          //是否自动播放，默认true
          autoPlay: true,
          //是否是否循环播放播放，默认true
          loop: true,
          //是否静音，默认true
          mute: true,
        ),
      ),
    );
  }
}
