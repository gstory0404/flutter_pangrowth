import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/playlet/playlet_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/18 14:45
/// @Email gstory0404@gmail.com
/// @Description: 搜索

class PlayletSearchPage extends StatefulWidget {
  const PlayletSearchPage({Key? key}) : super(key: key);

  @override
  State<PlayletSearchPage> createState() => _PlayletSearchPageState();
}

class _PlayletSearchPageState extends State<PlayletSearchPage> {
  var _playletList = <PlayletEntity>[];

  @override
  void initState() {
    super.initState();
  }

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
                  PangrowthPlaylet.requestCategoryPlayletLisWithSearchWord(
                          keyword: value, isFuzzy: true, page: 1, size: 30)
                      .then((value) {
                    _playletList.addAll(value ?? []);
                    setState(() {});
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _playletList.length,
                itemBuilder: (context, index) {
                  return PlayletItem(entity: _playletList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
