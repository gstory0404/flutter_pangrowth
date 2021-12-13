import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/3 5:36 下午
/// @Email gstory0404@gmail.com
/// @Description: 小说搜索

class SearchNovelDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      TextButton(
        child: Text("搜索"),
        onPressed: () => {showResults(context)},
      ),
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, ""),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<NovelEntity>(
      future: PangrowthNovel.searchNovelResults(
          queryContent: query, offset: 1, limit: 20),
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
                    itemBuilder: (context, index) {
                      NovelEntityData result = snapshot.data!.data![index];
                      return InkWell(
                        onTap: () async{
                          PangrowthNovel.openNovelPageWithUrl(url: result.readUrl);
                        },
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Row(
                            children: [
                              Image.network(
                                result.thumbUrl,
                                width: 90,
                                height: 120,
                                fit: BoxFit.fill,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 16, top: 4, bottom: 4),
                                  height: 120,
                                  child: Text(
                                    result.bookName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }
            return Container();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<NovelEntity>(
      future: PangrowthNovel.searchNovelSuggestions(queryContent: query),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Container();
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
                  itemBuilder: (context, index) {
                    NovelEntityData result = snapshot.data!.data![index];
                    return ListTile(
                      title: Text(result.bookName,style: const TextStyle(fontSize: 14),),
                      onTap: () {
                        PangrowthNovel.openNovelPageWithUrl(url: result.readUrl);
                      },
                    );
                  }
                );
              }
            }
            return Container();
        }
      },
    );
  }
}
