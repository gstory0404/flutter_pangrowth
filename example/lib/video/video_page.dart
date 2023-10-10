import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/video/video_assembly_page.dart';
import 'package:flutter_pangrowth_example/video/video_card_page.dart';
import 'package:flutter_pangrowth_example/video/video_in_page.dart';
import 'package:flutter_unionad/flutter_unionad.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/13 3:56 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('穿山甲内容输出插件---视频'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('视频--初始化: $_isRegister\n'),
            //打开沉浸式小视频
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('打开沉浸式小视频'),
              onPressed: () async {
                await PangrowthVideo.openDrawVideoFull();
              },
            ),
            //打开宫格小视频
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('打开宫格小视频'),
              onPressed: () async {
                await PangrowthVideo.openGridVideo();
              },
            ),
            //打开个人主页
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('打开个人主页'),
              onPressed: () async {
                await PangrowthVideo.openUserCenter();
              },
            ),
            //Flutter页面中插入视频新闻界面
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('Flutter页面中插入视频新闻界面'),
              onPressed: () async {
                if(Platform.isIOS){
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return VideoInPage();
                  }));
                }
              },
            ),
            //Flutter页面中插入视频新闻界面
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('视频组件'),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return VideoAssemblyPage();
                }));
              },
            ),
            //Flutter页面中插入视频新闻界面
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('视频卡片'),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return VideoCardPage();
                }));
              },
            ),
            // MaterialButton(
            //   color: Colors.blue,
            //   textColor: Colors.white,
            //   child: const Text('获取信息流数据'),
            //   onPressed: () async {
            //     PangrowthVideo.getFeedNativeData();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
