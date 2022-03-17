package com.example.flutter_pangrowth

import android.app.Activity
import android.content.Context
import com.alibaba.fastjson.JSON
import com.alibaba.fastjson.JSONObject
import com.bytedance.novel.pangolin.NovelConfig
import com.bytedance.novel.pangolin.NovelSDK
import com.bytedance.novel.pangolin.PangolinDocker
import com.bytedance.novel.pangolin.data.NormalFontType
import com.bytedance.novel.pangolin.data.NovelInfo
import com.bytedance.novel.pangolin.data.NovelRecordInfo
import com.bytedance.novel.pangolin.data.ReaderFontType
import com.example.flutter_pangrowth.entity.NovelBean
import com.example.flutter_pangrowth.entity.NovelEntity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * @Author: gstory
 * @CreateDate: 2021/12/13 3:13 下午
 * @Description: 描述
 */

object NovelPlugin {

    /**
     * 小说注册
     */
    fun registerNovel(context: Context?, call: MethodCall, result: MethodChannel.Result) {
        val appName = call.argument<String>("appName")
        val appVersionName = call.argument<String>("appVersionName")
        val appVersionCode = call.argument<Int>("appVersionCode")
        val channel = call.argument<String>("channel")
        val appId = call.argument<String>("andoridAppId")
        val personalRecommendAd = call.argument<Boolean>("personalRecommendAd")
        val personalRecommendContent = call.argument<Boolean>("personalRecommendContent")
        val normalFontType = call.argument<String>("normalFontType")
        val readFontType = call.argument<String>("readFontType")
        val config = NovelConfig.Builder()
                .appName(appName)
                .appVersionName(appVersionName)
                .appVersionCode(appVersionCode!!)
                .channel(channel)
                .initInnerApplog(true)
                .initInnerOpenAdSdk(false)
                .appId(appId)
                .jsonFileName("pangrowthconfig.json")
                .build()
        // 全局字号大小，可选
        if (normalFontType == "large") {
            config.normalFontSize = NormalFontType.NORMAL
        } else {
            config.normalFontSize = NormalFontType.LARGE
        }
        // 阅读器字号大小，可选
        when (readFontType) {
            "one" -> config.readerFontSize = ReaderFontType.ONE
            "there" -> config.readerFontSize = ReaderFontType.THREE
            "four" -> config.readerFontSize = ReaderFontType.FOUR
            "five" -> config.readerFontSize = ReaderFontType.FIVE
            "six" -> config.readerFontSize = ReaderFontType.SIX
            else -> config.readerFontSize = ReaderFontType.TWO
        }
        NovelSDK.attach(PangolinDocker(config), context!!)
        NovelSDK.updatePersonalRecommendationAd(personalRecommendAd!!)
        NovelSDK.updatePersonalRecommendationAd(personalRecommendContent!!)
        result.success(true)
    }

    /**
     * 打开小说主页
     */
    fun openNovelPage(activity: Activity?,result: MethodChannel.Result) {
        NovelSDK.openNovelPage(activity!!)
        result.success(true)
    }

    /**
     * 获取小说阅读历史记录
     */
    fun getNovelHistory(activity: Activity?, size: Int, result: MethodChannel.Result) {
        NovelSDK.getNovelRecord { novelRecordInfo ->
            if (novelRecordInfo == null) {
                var entity = NovelEntity(code = false, msg = "", data = null)
                val jsonObject: JSONObject = JSONObject.parseObject(JSON.toJSONString(entity))
                val map = jsonObject as Map<String, Any>
                activity!!.runOnUiThread {
                    result.success(map)
                }
            } else {
                var novel = NovelBean(readUrl = novelRecordInfo!!.novelInfo!!.readerUrl,
                        bookName = novelRecordInfo.novelInfo!!.name,
                        thumbUrl = novelRecordInfo.novelInfo!!.imageUrl,
                        novelDetail = JSON.toJSONString(novelRecordInfo),
                        type = 0)
                var novelList = listOf(novel)
                var entity = NovelEntity(code = true, msg = "", data = novelList)
                val jsonObject: JSONObject = JSONObject.parseObject(JSON.toJSONString(entity))
                val map = jsonObject as Map<String, Any>
                activity!!.runOnUiThread {
                    result.success(map)
                }
            }
        }
    }

    /**
     * 获取多本推荐小说  num需要介于1-10
     */
    fun getNovelRecommend(activity: Activity?, size: Int, result: MethodChannel.Result) {
        NovelSDK.getRecommendFeedNovel(size) { list ->
            var novelList: MutableList<NovelBean> = ArrayList()
            list?.forEach {
                var novel = NovelBean(readUrl = it!!.readerUrl,
                        bookName = it.name,
                        thumbUrl = it.imageUrl,
                        novelDetail = JSON.toJSONString(it),
                        type = 1)
                novelList.add(novel)
            }
            var entity = NovelEntity(code = true, msg = "", data = novelList)
            val jsonObject: JSONObject = JSONObject.parseObject(JSON.toJSONString(entity))
            val map = jsonObject as Map<String, Any>
            activity!!.runOnUiThread {
                result.success(map)
            }
        }
    }

    /**
     * 上报阅读历史展示，当获取了用户的阅读历史信息，展示的时候务必上报
     */
    fun reportRecentNovelShow(call: MethodCall, result: MethodChannel.Result) {
        val type = call.argument<Int>("type")
        val book = call.argument<String>("book")
        if (type == 0) {
            val novel = JSON.parseObject(book, NovelRecordInfo::class.java)
            NovelSDK.reportRecentNovelShow(novel.novelInfo!!)
            result.success(true)
        } else if (type == 1) {
            val novel = JSON.parseObject(book, NovelInfo::class.java)
            NovelSDK.reportRecentNovelShow(novel)
            result.success(true)
        } else if (type == 2) {
            val novel = JSON.parseObject(book, NovelRecordInfo::class.java)
            NovelSDK.reportRecentNovelShow(novel.novelInfo!!)
            result.success(true)
        } else {
            result.success(false)
        }

    }

    /**
     * 上报阅读点击，当用户点击了阅读历史信息，务必上报
     */
    fun reportRecentNovelClick(call: MethodCall, result: MethodChannel.Result) {
        val type = call.argument<Int>("type")
        val book = call.argument<String>("book")
        if (type == 0) {
            val novel = JSON.parseObject(book, NovelRecordInfo::class.java)
            NovelSDK.reportRecentNovelShow(novel.novelInfo!!)
            result.success(true)
        } else if (type == 1) {
            val novel = JSON.parseObject(book, NovelInfo::class.java)
            NovelSDK.reportRecentNovelShow(novel)
            result.success(true)
        } else {
            result.success(false)
        }

    }

    /**
     * 打开小说
     */
    fun openNovelPageWithConfig(activity: Activity?, call: MethodCall, result: MethodChannel.Result) {
        val type = call.argument<Int>("type")
        val book = call.argument<String>("book")
        if (type == 0) {
            val novel = JSON.parseObject(book, NovelRecordInfo::class.java)
            NovelSDK.openNovelReader(activity!!, novel.novelInfo!!)
            result.success(true)
        } else if (type == 1) {
            val novel = JSON.parseObject(book, NovelInfo::class.java)
            NovelSDK.openNovelReader(activity!!, novel)
            result.success(true)
        } else if (type == 2) {
            val novel = JSON.parseObject(book, NovelRecordInfo::class.java)
            NovelSDK.openNovelReader(activity!!, novel.novelInfo!!)
            result.success(true)
        } else {
            result.success(false)
        }
    }

    /**
     * 打开小说url
     */
    fun openNovelPageWithUrl(activity: Activity?, call: MethodCall, result: MethodChannel.Result) {
        val url = call.argument<String>("url")
        NovelSDK.openNovelReaderByUrl(activity!!, url!!)
        result.success(true)
    }


    /**
     * 搜索Sug页
     */
    fun searchNovelSuggestions(activity: Activity?, queryContent: String, result: MethodChannel.Result) {

        NovelSDK.getSearchSug(queryContent) { list ->
            var novelList: MutableList<NovelBean> = ArrayList()
            list?.forEach {
                var novel = NovelBean(readUrl = it.itemSchemaUrl,
                        bookName = it.bookName,
                        thumbUrl = it.thumbUrl,
                        novelDetail = JSON.toJSONString(it),
                        type = 1)
                novelList.add(novel)
            }
            var entity = NovelEntity(code = true, msg = "", data = novelList)
            val jsonObject: JSONObject = JSONObject.parseObject(JSON.toJSONString(entity))
            val map = jsonObject as Map<String, Any>
            activity!!.runOnUiThread {
                result.success(map)
            }
        }
    }

    /**
     * 搜索结果页
     */
    fun searchNovelResults(activity: Activity?, queryContent: String, result: MethodChannel.Result) {
        NovelSDK.getSearchResultPage(queryContent) { list ->
            var novelList: MutableList<NovelBean> = ArrayList()
            list?.forEach {
                var novel = NovelBean(readUrl = it.itemSchemaUrl,
                        bookName = it.bookName,
                        thumbUrl = it.thumbUrl,
                        novelDetail = JSON.toJSONString(it),
                        type = 1)
                novelList.add(novel)
            }
            var entity = NovelEntity(code = true, msg = "", data = novelList)
            val jsonObject: JSONObject = JSONObject.parseObject(JSON.toJSONString(entity))
            val map = jsonObject as Map<String, Any>
            activity!!.runOnUiThread {
                result.success(map)
            }
        }
    }
}