import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/playlet/playlet_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/15 17:41
/// @Email gstory0404@gmail.com
/// @Description: 分页获取短剧

class PlayletLimitPage extends StatefulWidget {
  const PlayletLimitPage({Key? key}) : super(key: key);

  @override
  State<PlayletLimitPage> createState() => _PlayletAllPageState();
}

class _PlayletAllPageState extends State<PlayletLimitPage> {
  var _playletList = <PlayletEntity>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  _query() async {
    PangrowthPlaylet.requestAllPlayletListPage(page: 1, size: 30, order: 1)
        .then((value) {
      _playletList.addAll(value ?? []);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("短剧分页加载"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView.builder(
          itemCount: _playletList.length,
          itemBuilder: (context, index) {
            return PlayletItem(entity: _playletList[index]);
          },
        ),
      ),
    );
  }
}
