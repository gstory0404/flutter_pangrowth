import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/playlet/playlet_category_list_page.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/18 15:39
/// @Email gstory0404@gmail.com
/// @Description: 短剧分类列表

class PlayletCategoryPage extends StatefulWidget {
  const PlayletCategoryPage({Key? key}) : super(key: key);

  @override
  State<PlayletCategoryPage> createState() => _PlayletCategoryPageState();
}

class _PlayletCategoryPageState extends State<PlayletCategoryPage> {
  var _list = <String>[];

  @override
  void initState() {
    super.initState();
    _query();
  }

  _query() {
    PangrowthPlaylet.requestPlayletCategoryList().then((value) {
      if (value != null) {
        _list = value;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("短剧分类"),
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return PlayletCategoryListPage(category: category);
                    }));
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
