import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/novel/novel_category_page.dart';
import 'package:flutter_pangrowth_example/novel/novel_collect_page.dart';
import 'package:flutter_pangrowth_example/novel/novel_history_page.dart';
import 'package:flutter_pangrowth_example/novel/novel_ids_page.dart';
import 'package:flutter_pangrowth_example/novel/novel_limit_page.dart';
import 'package:flutter_pangrowth_example/novel/novel_search_page.dart';
// import 'package:flutter_unionad/flutter_unionad.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/6 4:38 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class NovelPage extends StatefulWidget {
  const NovelPage({Key? key}) : super(key: key);

  @override
  _NovelPageState createState() => _NovelPageState();
}

class _NovelPageState extends State<NovelPage> {
  bool _isRegister = false;

  @override
  void initState() {
    super.initState();
    _register();
  }

  ///初始化
  Future<void> _register() async {
    _isRegister = await PangrowthNovel.registerNovel(debug: true);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('穿山甲内容输出插件---小说'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('短小说--初始化: $_isRegister\n'),
            //激励广告
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('短小说聚合页'),
              onPressed: () async {
                await PangrowthNovel.openNovelAggregatePage(
                  adCode: "961597868",
                );
              },
            ),
            //搜索小说
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('搜索小说'),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return NovelSearchPage();
                }));
              },
            ),
            //根据ids查询短小说
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('根据ids查询短小说'),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return NovelIdsPage();
                }));
              },
            ),
            //根据ids查询短小说
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('短小说分页加载'),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return NovelLimitPage();
                }));
              },
            ),
            //短小说阅读记录
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('短小说阅读记录'),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return NovelHistoryPage();
                }));
              },
            ),
            //短小说收藏列表
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('短小说收藏列表'),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return NovelCollectPage();
                }));
              },
            ),

            //获取阅读历史，单本
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('短小说分类'),
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return NovelCategoryPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
