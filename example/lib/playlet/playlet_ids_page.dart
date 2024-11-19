import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/playlet/playlet_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/15 17:41
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class PlayletIdsPage extends StatefulWidget {
  const PlayletIdsPage({Key? key}) : super(key: key);

  @override
  State<PlayletIdsPage> createState() => _PlayletIdsPageState();
}

class _PlayletIdsPageState extends State<PlayletIdsPage> {
  var _playletList = <PlayletEntity>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  _query() async {
    PangrowthPlaylet.requestPlayletListWithPlayletId(ids: ["17916","17917"])
        .then((value) {
      _playletList.addAll(value ?? []);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("全部短剧"),
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
