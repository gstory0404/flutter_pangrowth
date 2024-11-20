import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
import 'package:flutter_pangrowth_example/playlet/playlet_category_list_page.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/18 12:26
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class PlayletItem extends StatefulWidget {
  PlayletEntity entity;

  PlayletItem({Key? key, required this.entity}) : super(key: key);

  @override
  State<PlayletItem> createState() => _PlayletItemState();
}

class _PlayletItemState extends State<PlayletItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PangrowthPlaylet.enterPlayletPlayer(
            playletId: widget.entity.playletId ?? 0,
            index: widget.entity.currentEpisode ?? 0);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "${widget.entity.coverImage}",
                width: 100,
                height: 140,
                fit: BoxFit.cover,
              ),
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
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return PlayletCategoryListPage(
                              category: "${widget.entity.categoryName}");
                        }));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        margin: EdgeInsets.only(bottom: 10, right: 10, top: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Text(
                          "${widget.entity.categoryName}",
                          style: TextStyle(fontSize: 14),
                          maxLines: 1,
                        ),
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
                            child: Text((widget.entity.likeState ?? 0) == 1
                                ? "已点赞"
                                : "点赞"),
                          ),
                          onTap: () {
                            if ((widget.entity.likeState ?? 0) == 1) {
                              PangrowthPlaylet.cancelLikeShortplay(
                                      playletId: widget.entity.playletId ?? 0,
                                      index: widget.entity.currentEpisode ?? 0)
                                  .then(
                                (value) {
                                  if (value) {
                                    setState(() {
                                      widget.entity.likeState = 0;
                                    });
                                  }
                                },
                              );
                            } else {
                              PangrowthPlaylet.likeShortplay(
                                      playletId: widget.entity.playletId ?? 0,
                                      index: widget.entity.currentEpisode ?? 0)
                                  .then(
                                (value) {
                                  if (value) {
                                    setState(() {
                                      widget.entity.likeState = 1;
                                    });
                                  }
                                },
                              );
                            }
                          },
                        ),
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
                              PangrowthPlaylet.cancelCollectShortplay(
                                      playletId: widget.entity.playletId ?? 0)
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
                              PangrowthPlaylet.collectShortplay(
                                      playletId: widget.entity.playletId ?? 0)
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
