package com.example.flutter_pangrowth.entity

import androidx.annotation.Keep

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
"readUrl": "",
"bookName": "",
"readUrl": "",
"thumbUrl": "http: //p3-novel.byteimg.com/origin/novel-images/471a2521ed5a8a35559df077a8486c10",
"novelDetail": ""
}
]
}
 **/

@Keep
data class NovelEntity(
        val code: Boolean,
        val msg: String?,
        val data: List<NovelBean>?
)

@Keep
data class NovelBean(
        val readUrl: String,
        val bookName: String,
        val thumbUrl: String,
        val type: Int,
        val novelDetail: String
)