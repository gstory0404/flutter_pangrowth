import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/novel/novel_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/19 10:32
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class NovelIdsPage extends StatefulWidget {
  const NovelIdsPage({Key? key}) : super(key: key);

  @override
  State<NovelIdsPage> createState() => _NovelIdsPageState();
}

class _NovelIdsPageState extends State<NovelIdsPage> {
  var _novelList = <NovelEntity>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  _query() async {
    PangrowthNovel.requestStoryListWithBookId(ids: ["6331","8178"])
        .then((value) {
      _novelList.addAll(value ?? []);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("根据ids查询短小说"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView.builder(
          itemCount: _novelList.length,
          itemBuilder: (context, index) {
            return NovelItem(entity: _novelList[index]);
          },
        ),
      ),
    );
  }
}
