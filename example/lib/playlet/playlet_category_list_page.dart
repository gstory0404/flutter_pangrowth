import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/playlet/playlet_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/15 17:41
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class PlayletCategoryListPage extends StatefulWidget {
  String category;

  PlayletCategoryListPage({Key? key, required this.category}) : super(key: key);

  @override
  State<PlayletCategoryListPage> createState() => _PlayletAllPageState();
}

class _PlayletAllPageState extends State<PlayletCategoryListPage> {
  var _playletList = <PlayletEntity>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  _query() async {
    PangrowthPlaylet.requestCategoryPlayletLisWithCategory(category:widget.category,page:1,size:30).then((value) {
      _playletList.addAll(value ?? []);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
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
