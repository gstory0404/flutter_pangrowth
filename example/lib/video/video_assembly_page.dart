import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/video/video_in_page.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/13 3:56 下午
/// @Email gstory0404@gmail.com
/// @Description: 视频组件--banner

class VideoAssemblyPage extends StatefulWidget {
  const VideoAssemblyPage({Key? key}) : super(key: key);

  @override
  _VideoBannerPageState createState() => _VideoBannerPageState();
}

class _VideoBannerPageState extends State<VideoAssemblyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('视频组件'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("视频组件-Banner"),
            PangrowthVideo.videoBannerView(
              viewWidth: 300,
              viewHeight: 200,
            ),
            const Text("视频组件-文字链"),
            PangrowthVideo.videoTextChainView(viewWidth: 300, viewHeight: 50),
            const Text("视频组件-气泡"),
            PangrowthVideo.videoBubbleView(
                viewWidth: 300, viewHeight: 50, title: "热门视频"),
          ],
        ),
      ),
    );
  }
}
