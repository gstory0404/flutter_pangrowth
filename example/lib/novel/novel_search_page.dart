import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/novel/novel_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/19 09:15
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class NovelSearchPage extends StatefulWidget {
  const NovelSearchPage({Key? key}) : super(key: key);

  @override
  State<NovelSearchPage> createState() => _NovelSearchPageState();
}

class _NovelSearchPageState extends State<NovelSearchPage> {
  var _novelList = <NovelEntity>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              child: new TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                  hintText: '请输入搜索内容',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color(0xffaaaaaa).withOpacity(0.3),
                ),
                onChanged: (value) {
                  PangrowthNovel.requestStoryListWithSearchWord(
                          keyword: value, isFuzzy: true, page: 1, size: 30)
                      .then((value) {
                    _novelList = value ?? [];
                    setState(() {});
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _novelList.length,
                itemBuilder: (context, index) {
                  return NovelItem(entity: _novelList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
