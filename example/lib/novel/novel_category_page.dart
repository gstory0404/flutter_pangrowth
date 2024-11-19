import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/18 18:52
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class NovelCategoryPage extends StatefulWidget {
  const NovelCategoryPage({Key? key}) : super(key: key);

  @override
  State<NovelCategoryPage> createState() => _NovelCategoryPageState();
}

class _NovelCategoryPageState extends State<NovelCategoryPage> {
  var _list = <String>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  _query() {
    PangrowthNovel.requestNovelCategoryList().then((value) {
      print(value);
      if (value != null) {
        // _list = value;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("短小说分类"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Wrap(
          children: _list
              .map(
                (String category) => GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                margin: EdgeInsets.only(bottom: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(category),
              ),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (_) {
                //   return PlayletCategoryListPage(category: category);
                // }));
              },
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}
