import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/novel/novel_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/19 10:51
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class NovelCategoryList extends StatefulWidget {
  String name;
  int id;

  NovelCategoryList({Key? key,required this.name, required this.id}) : super(key: key);

  @override
  State<NovelCategoryList> createState() => _NovelCategoryListState();
}

class _NovelCategoryListState extends State<NovelCategoryList> {
  var _novelList = <NovelEntity>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  _query() async {
    PangrowthNovel.requestCategoryStoryListWithCategoryId(
            categoryId: widget.id, page: 1, size: 30, order: 1)
        .then((value) {
      _novelList.addAll(value ?? []);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
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
