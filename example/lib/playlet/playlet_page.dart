import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/playlet/playlet_card_page.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

/// @Author: gstory
/// @CreateDate: 2023/10/10 12:09
/// @Email gstory0404@gmail.com
/// @Description: 短剧

class PlayletPage extends StatefulWidget {
  const PlayletPage({Key? key}) : super(key: key);

  @override
  State<PlayletPage> createState() => _PlayletPageState();
}

class _PlayletPageState extends State<PlayletPage> {
  bool _isRegister = false;

  @override
  void initState() {
    super.initState();
    _register();
  }

  ///初始化
  Future<void> _register() async {
    bool _adRegister = await FlutterUnionad.register(
        androidAppId: "5240945",
        //穿山甲广告 Android appid 必填
        iosAppId: "5205916",
        //穿山甲广告 ios appid 必填
        useTextureView: true,
        //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView 选填
        appName: "appName",
        //appname 必填
        allowShowNotify: true,
        //是否允许sdk展示通知栏提示 选填
        allowShowPageWhenScreenLock: true,
        //是否在锁屏场景支持展示广告落地页 选填
        debug: true,
        //是否显示debug日志
        supportMultiProcess: true,
        //是否支持多进程，true支持 选填
        directDownloadNetworkType: [
          FlutterUnionadNetCode.NETWORK_STATE_2G,
          FlutterUnionadNetCode.NETWORK_STATE_3G,
          FlutterUnionadNetCode.NETWORK_STATE_4G,
          FlutterUnionadNetCode.NETWORK_STATE_WIFI
        ]); //允许直接下载的网络状态集合 选填
    print("广告初始化结果--> $_adRegister");
    _isRegister = await PangrowthVideo.registerVideo(
      //接入小说SDK的App的英文名 必填
      appName: "appName",
      ////appid 必填
      andoridAppId: "302043",
      iosAppId: "299886",
      //是否显示日志
      debug: true,
    );
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('穿山甲内容输出插件---短剧'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('视频--初始化: $_isRegister\n'),
            //打开短剧聚合页
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('短剧聚合页'),
              onPressed: () async {
                await PangrowthPlaylet.openPlayletAggregatePage(
                  // 免费观看的集数 默认3
                  freeCount: 10,
                  // 观看一次激励视频解锁的集数 默认1
                  unlockCountUsingAD: 2,
                  //是否展示导航栏标题名称 默认true
                  isShowTitle: true,
                  //是否展示导航栏左上角返回按钮 默认true
                  isShowBackButton: true,
                );
              },
            ),
            //打开短剧聚合页
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('短剧短视频混排页'),
              onPressed: () async {
                await PangrowthPlaylet.openPlayletDrawVideoPage(
                  // 免费观看的集数 默认3
                  freeCount: 5,
                  // 观看一次激励视频解锁的集数 默认1
                  unlockCountUsingAD: 2,
                  //是否展示导航栏标题名称 默认true
                  isShowTitle: false,
                  //是否展示导航栏左上角返回按钮 默认true
                  isShowBackButton: true,
                  //是否短视频、短剧混排 默认true
                  isVideoPlaylet: false,
                  // 短剧混排流中的免费短剧集数，默认3
                  playletFreeCount: 5,
                  // 短剧混排流中要第一部展现的短剧id 默认0
                  topSkitId: 0,
                );
              },
            ),
            //打开短剧聚合页
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('短剧搜索页面'),
              onPressed: () async {
                await PangrowthPlaylet.openPlayletSearchPage();
              },
            ),
            //打开短剧卡片
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('短剧卡片'),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return PlayletCardPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
