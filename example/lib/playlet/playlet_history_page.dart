import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/playlet/playlet_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/15 17:41
/// @Email gstory0404@gmail.com
/// @Description: 短剧播放记录

class PlayletHistoryPage extends StatefulWidget {
  const PlayletHistoryPage({Key? key}) : super(key: key);

  @override
  State<PlayletHistoryPage> createState() => _PlayletAllPageState();
}

class _PlayletAllPageState extends State<PlayletHistoryPage> {
  var _playletList = <PlayletEntity>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  _query() async {
    PangrowthPlaylet.requestPlayletHistoryListWithPage(page: 1, size: 30)
        .then((value) {
      _playletList.addAll(value ?? []);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("短剧播放记录"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await PangrowthPlaylet.requestPlayletHistoryClean();
              _query();
            },
          ),
        ],
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
