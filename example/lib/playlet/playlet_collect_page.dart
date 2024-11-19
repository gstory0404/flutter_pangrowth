import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/playlet/playlet_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/18 17:46
/// @Email gstory0404@gmail.com
/// @Description: 短剧收藏列表

class PlayletCollectPage extends StatefulWidget {
  const PlayletCollectPage({Key? key}) : super(key: key);

  @override
  State<PlayletCollectPage> createState() => _PlayletCollectPageState();
}

class _PlayletCollectPageState extends State<PlayletCollectPage> {
  var _playletList = <PlayletEntity>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  _query() async {
    PangrowthPlaylet.requestCollectionList(page: 1, size: 30)
        .then((value) {
      _playletList.addAll(value ?? []);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("短剧收藏列表"),
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
