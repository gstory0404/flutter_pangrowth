package com.example.flutter_pangrowth.entity

/**
 * @Author: gstory
 * @CreateDate: 2021/12/7 3:44 下午
 * @Description: 描述
 */
/**
{
"code": 0,
"msg": "",
"data": [
{
"bookId": "6806002909138914318",
"bookName": "",
"readUrl": "",
"thumbUrl": "http: //p3-novel.byteimg.com/origin/novel-images/471a2521ed5a8a35559df077a8486c10",
"novelDetail": ""
}
]
}
 **/
data class NovelEntity(
        val code: Boolean,
        val msg: String?,
        val data: List<NovelBean>?
)

data class NovelBean(
        val bookId: String,
        val bookName: String,
        val thumbUrl: String,
        val type: Int,
        val novelDetail: String
)