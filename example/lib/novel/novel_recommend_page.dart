import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/3 5:36 下午
/// @Email gstory0404@gmail.com
/// @Description: 阅读历史

class NovelRecommendPage extends StatefulWidget {

  String type;

  NovelRecommendPage({Key? key,required this.type}) : super(key: key);

  @override
  _NovelRecommendV1State createState() => _NovelRecommendV1State();
}

class _NovelRecommendV1State extends State<NovelRecommendPage> {

  Future<NovelEntity> getNovel() async{
    switch(widget.type){
      case "history":
        return PangrowthNovel.getNovelHistory();
      case "feedV1":
        return PangrowthNovel.getNovelRecommendV1(size: 10);
    }
    return PangrowthNovel.getNovelRecommendFeed(size: 10);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("启动后推荐书列表"),
        centerTitle: true,
      ),
      body: FutureBuilder<NovelEntity>(
        future: PangrowthNovel.getNovelRecommendV1(
          size: 10,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
            // 当前没有连接到任何的异步任务
            case ConnectionState.waiting:
              return Container();
            // 连接到异步任务并等待进行交互
            case ConnectionState.active:
              return Container(
                child: const Center(
                  child: Text("加载数据中..."),
                ),
              );
            // 连接到异步任务并开始交互
            case ConnectionState.done:
              if (snapshot.hasError) {
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
                          await PangrowthNovel.reportRecentNovelShow(
                              type: result.type, book: result.novelDetail);
                          //书籍跳转
                          await PangrowthNovel.openNovelPageWithConfig(
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
