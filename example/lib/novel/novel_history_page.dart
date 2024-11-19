import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/novel/novel_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/19 10:58
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述
class NovelHistoryPage extends StatefulWidget {
  const NovelHistoryPage({Key? key}) : super(key: key);


  @override
  State<NovelHistoryPage> createState() => _NovelHistoryPageState();
}

class _NovelHistoryPageState extends State<NovelHistoryPage> {
  var _novelList = <NovelEntity>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  _query() async {
    PangrowthNovel.requestHistoryStoryList(page: 1,size: 30)
        .then((value) {
      _novelList.addAll(value ?? []);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("短小说阅读记录"),
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
