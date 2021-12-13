import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/3 5:36 下午
/// @Email gstory0404@gmail.com
/// @Description: 阅读历史

class NovelHistoryPage extends StatefulWidget {
  const NovelHistoryPage({Key? key}) : super(key: key);

  @override
  _NovelHistoryState createState() => _NovelHistoryState();
}

class _NovelHistoryState extends State<NovelHistoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("阅读历史"),
        centerTitle: true,
      ),
      body: FutureBuilder<NovelEntity>(
        future: FlutterPangrowth.getNovelHistory(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
            case ConnectionState.waiting:
              return Container();
            case ConnectionState.active:
              return Container(
                child: const Center(
                  child: Text("加载数据中..."),
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                print("错误=》${snapshot.error}");
                return Container(
                  child: const Center(
                    child: Text("加载数据失败"),
                  ),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data!.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data == null
                        ? 0
                        : snapshot.data?.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      NovelEntityData result =
                      snapshot.data!.data![index];
                      return InkWell(
                        onTap: () async {
                          //书籍曝光
                          await FlutterPangrowth.reportRecentNovelShow(
                              type: result.type, book: result.novelDetail);
                          //书籍点击
                          await FlutterPangrowth.reportRecentNovelClick(
                              type: result.type, book: result.novelDetail);
                          //书籍跳转
                          await FlutterPangrowth.openNovelPageWithConfig(
                              type: result.type, book: result.novelDetail);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Image.network(
                                result.thumbUrl,
                                width: 90,
                                height: 120,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 14),
                                child: Text(
                                  result.bookName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }
              return Container();
          }
        },
      ),
    );
  }
}
