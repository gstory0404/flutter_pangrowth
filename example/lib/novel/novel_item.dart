import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/novel/novel_category_list.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/19 09:54
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class NovelItem extends StatefulWidget {
  NovelEntity entity;

  NovelItem({Key? key,required this.entity}) : super(key: key);
  @override
  State<NovelItem> createState() => _NovelItemState();
}

class _NovelItemState extends State<NovelItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PangrowthNovel.openMiniStory(
            novelId: widget.entity.bookId ?? 0,
            index: widget.entity.index ?? 0);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Image.network(
              "${widget.entity.coverImage}",
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.entity.title}",
                      style: TextStyle(fontSize: 16),
                      maxLines: 1,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return NovelCategoryList(name:"${widget.entity.categoryName}",id: widget.entity.categoryId ?? 0);
                        }));
                      },
                      child: Text(
                        "${widget.entity.categoryName} - ${widget.entity.author}",
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      "${widget.entity.desc}",
                      style: TextStyle(fontSize: 12),
                      maxLines: 2,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            margin:
                            EdgeInsets.only(bottom: 10, right: 10, top: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius:
                              BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Text((widget.entity.favoriteState ?? 0) == 1
                                ? "已收藏"
                                : "收藏"),
                          ),
                          onTap: () {
                            if ((widget.entity.favoriteState ?? 0) == 1) {
                              PangrowthNovel.requestCancelCollectStory(
                                  novelId: widget.entity.bookId ?? 0)
                                  .then(
                                    (value) {
                                  if (value) {
                                    setState(() {
                                      widget.entity.favoriteState = 0;
                                    });
                                  }
                                },
                              );
                            } else {
                              PangrowthNovel.requestCollectStory(
                                  novelId: widget.entity.bookId ?? 0)
                                  .then(
                                    (value) {
                                  if (value) {
                                    setState(() {
                                      widget.entity.favoriteState = 1;
                                    });
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}