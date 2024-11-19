import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/playlet/playlet_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/18 12:33
/// @Email gstory0404@gmail.com
/// @Description: 短剧推荐

class PlayletRecommendPage extends StatefulWidget {
  const PlayletRecommendPage({Key? key}) : super(key: key);

  @override
  State<PlayletRecommendPage> createState() => _PlayletRecommendPageState();
}

class _PlayletRecommendPageState extends State<PlayletRecommendPage> {
  var _playletList = <PlayletEntity>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  _query() async {
    PangrowthPlaylet.requestRecommendedPlayletListPage(
      page: 1,
      size: 30,
    ).then((value) {
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
