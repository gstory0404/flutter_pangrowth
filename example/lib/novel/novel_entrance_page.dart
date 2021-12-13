import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/7 2:12 下午
/// @Email gstory0404@gmail.com
/// @Description: 小说导流入口控件

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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("金刚位"),
              PangrowthNovel.novelEntranceView(
                viewWidth: 50,//宽
                viewHeight: 50,//高
                type: FlutterNovelEntranceType.icon,//类型
                style: FlutterNovelIconSytle.circle,//类型下对应样式
              ),
              PangrowthNovel.novelEntranceView(
                viewWidth: 50,
                viewHeight: 50,
                type: FlutterNovelEntranceType.icon,
                style: FlutterNovelIconSytle.rect,
              ),
              const Text("悬浮球"),
              PangrowthNovel.novelEntranceView(
                viewWidth: 50,
                viewHeight: 120,
                type: FlutterNovelEntranceType.floatBall,
                style: FlutterNovelFloatBallSytle.withClose,
              ),
              PangrowthNovel.novelEntranceView(
                viewWidth: 50,
                viewHeight: 120,
                type: FlutterNovelEntranceType.floatBall,
                style: FlutterNovelFloatBallSytle.withoutClose,
              ),
              const Text("Banner"),
              PangrowthNovel.novelEntranceView(
                viewWidth: 300,
                viewHeight: 100,
                type: FlutterNovelEntranceType.banner,
                style: FlutterNovelBannerSytle.small,
              ),
              PangrowthNovel.novelEntranceView(
                viewWidth: 300,
                viewHeight: 150,
                type: FlutterNovelEntranceType.banner,
                style: FlutterNovelBannerSytle.medium,
              ),
              PangrowthNovel.novelEntranceView(
                viewWidth: 300,
                viewHeight: 200,
                type: FlutterNovelEntranceType.banner,
                style: FlutterNovelBannerSytle.large,
              ),
              const Text("Window"),
              PangrowthNovel.novelEntranceView(
                viewWidth: 300,
                viewHeight: 100,
                type: FlutterNovelEntranceType.window,
                style: FlutterNovelWindowSytle.color1,
              ),
              PangrowthNovel.novelEntranceView(
                viewWidth: 300,
                viewHeight: 100,
                type: FlutterNovelEntranceType.window,
                style: FlutterNovelWindowSytle.color2,
              ),
              const Text("Feed单本"),
              PangrowthNovel.novelEntranceView(
                viewWidth: 400,
                viewHeight: 200,
                type: FlutterNovelEntranceType.feedSingle,
                style: FlutterNovelFeedSytle.normal,
              ),
              const Text("Feed多本"),
              PangrowthNovel.novelEntranceView(
                viewWidth: 400,
                viewHeight: 500,
                type: FlutterNovelEntranceType.feedList,
                style: FlutterNovelFeedSytle.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
