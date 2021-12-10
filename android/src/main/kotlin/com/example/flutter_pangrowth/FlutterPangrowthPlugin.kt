package com.example.flutter_pangrowth

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.bytedance.novel.pangolin.NovelConfig
import com.bytedance.novel.pangolin.NovelSDK
import com.bytedance.novel.pangolin.PangolinDocker
import com.example.flutter_pangrowth.entity.NovelBean
import com.example.flutter_pangrowth.entity.NovelEntity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.alibaba.fastjson.JSON
import com.alibaba.fastjson.JSONObject
import com.bytedance.novel.pangolin.data.NormalFontType
import com.bytedance.novel.pangolin.data.NovelInfo
import com.bytedance.novel.pangolin.data.NovelRecordInfo
import com.bytedance.novel.pangolin.data.ReaderFontType


/** FlutterPangrowthPlugin */
class FlutterPangrowthPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private var applicationContext: Context? = null
    private var mActivity: Activity? = null
    private lateinit var channel: MethodChannel
    private var mFlutterPluginBinding: FlutterPlugin.FlutterPluginBinding?  = null

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mActivity = binding.activity
//        Log.e("FlutterUnionadPlugin->","onAttachedToActivity")
    FlutterPangrowthViewPlugin.registerWith(mFlutterPluginBinding!!,mActivity!!)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        mActivity = binding.activity
//        Log.e("FlutterUnionadPlugin->","onReattachedToActivityForConfigChanges")
    }

    override fun onDetachedFromActivityForConfigChanges() {
        mActivity = null
//        Log.e("FlutterUnionadPlugin->","onDetachedFromActivityForConfigChanges")
    }

    override fun onDetachedFromActivity() {
        mActivity = null
//        Log.e("FlutterUnionadPlugin->","onDetachedFromActivity")
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_pangrowth")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
        mFlutterPluginBinding = flutterPluginBinding
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        //小说初始化
        if (call.method == "registerNovel") {
            registerNovel(call, result)
            //打开书城
        } else if (call.method == "openNovelPage") {
            NovelSDK.openNovelPage(mActivity!!)
            //获取小说阅读历史记录
        } else if (call.method == "getNovelHistory") {
            val size = call.argument<Int>("size")
            getNovelHistory(size!!, result)
        } else if (call.method == "getNovelRecommendV1") {
            val size = call.argument<Int>("size")
            getNovelRecommend(size!!, result)
        } else if (call.method == "getNovelRecommendFeed") {
            val size = call.argument<Int>("size")
            getNovelRecommend(size!!, result)
            //上报阅读历史展示，当获取了用户的阅读历史信息，展示的时候务必上报
        } else if (call.method == "reportRecentNovelShow") {
            reportRecentNovelShow(call, result)
            //上报阅读点击，当用户点击了阅读历史信息，务必上报
        } else if (call.method == "reportRecentNovelClick") {
            reportRecentNovelClick(call, result)
            ////打开一个书籍的阅读页面或者详情页面（如果是阅读历史就会打开阅读页面，推荐书籍会打开详情页面）
        } else if (call.method == "openNovelPageWithConfig") {
            openNovelPageWithConfig(call, result)
        } else if (call.method == "openNovelPageWithUrl") {
            openNovelPageWithUrl(call, result)
            //获取小说阅读时长
        } else if (call.method == "getReadDuration") {
            result.success(NovelSDK.getNovelReadingDuration())
            //小说搜索Sug页
        } else if (call.method == "searchNovelSuggestions") {
            val queryContent = call.argument<String>("queryContent")
            searchNovelSuggestions(queryContent!!, result)
            //小说搜索结果页
        } else if (call.method == "searchNovelResults") {
            val queryContent = call.argument<String>("queryContent")
            searchNovelResults(queryContent!!, result)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /**
     * 小说注册
     */
    private fun registerNovel(call: MethodCall, result: Result) {
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
        if(normalFontType == "large"){
            config.normalFontSize =NormalFontType.NORMAL
        }else{
            config.normalFontSize =NormalFontType.LARGE
        }
        // 阅读器字号大小，可选
        when (readFontType){
            "one" -> config.readerFontSize = ReaderFontType.ONE
            "there" -> config.readerFontSize = ReaderFontType.THREE
            "four" -> config.readerFontSize = ReaderFontType.FOUR
            "five" -> config.readerFontSize = ReaderFontType.FIVE
            "six" -> config.readerFontSize = ReaderFontType.SIX
            else -> config.readerFontSize = ReaderFontType.TWO
        }
        NovelSDK.attach(PangolinDocker(config), applicationContext!!)
        NovelSDK.updatePersonalRecommendationAd(personalRecommendAd!!)
        NovelSDK.updatePersonalRecommendationAd(personalRecommendContent!!)
        result.success(true)
    }

    /**
     * 获取小说阅读历史记录
     */
    private fun getNovelHistory(size: Int, result: Result) {
        NovelSDK.getNovelRecord { novelRecordInfo ->
            if (novelRecordInfo == null) {
                var entity = NovelEntity(code = false, msg = "", data = null)
                val jsonObject: JSONObject = JSONObject.parseObject(JSON.toJSONString(entity))
                val map = jsonObject as Map<String, Any>
                mActivity!!.runOnUiThread {
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
                mActivity!!.runOnUiThread {
                    result.success(map)
                }
            }
        }
    }

    /**
     * 获取多本推荐小说  num需要介于1-10
     */
    private fun getNovelRecommend(size: Int, result: Result) {
        NovelSDK.getRecommendFeedNovel(size) { list ->
            var novelList :MutableList<NovelBean> = ArrayList()
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
            mActivity!!.runOnUiThread {
                result.success(map)
            }
        }
    }

    /**
     * 上报阅读历史展示，当获取了用户的阅读历史信息，展示的时候务必上报
     */
    private fun reportRecentNovelShow(call: MethodCall, result: Result) {
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
    private fun reportRecentNovelClick(call: MethodCall, result: Result) {
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
    private fun openNovelPageWithConfig(call: MethodCall, result: Result) {
        val type = call.argument<Int>("type")
        val book = call.argument<String>("book")
        if (type == 0) {
            val novel = JSON.parseObject(book, NovelRecordInfo::class.java)
            NovelSDK.openNovelReader(mActivity!!, novel.novelInfo!!)
            result.success(true)
        } else if (type == 1) {
            val novel = JSON.parseObject(book, NovelInfo::class.java)
            NovelSDK.openNovelReader(mActivity!!, novel)
            result.success(true)
        } else if (type == 2) {
            val novel = JSON.parseObject(book, NovelRecordInfo::class.java)
            NovelSDK.openNovelReader(mActivity!!, novel.novelInfo!!)
            result.success(true)
        } else {
            result.success(false)
        }
    }

    /**
     * 打开小说url
     */
    private fun openNovelPageWithUrl(call: MethodCall, result: Result) {
        val url = call.argument<String>("url")
        NovelSDK.openNovelReaderByUrl(mActivity!!, url!!)
        result.success(true)
    }


    /**
     * 搜索Sug页
     */
    private fun searchNovelSuggestions(queryContent: String, result: Result) {

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
            mActivity!!.runOnUiThread {
                result.success(map)
            }
        }
    }

    /**
     * 搜索结果页
     */
    private fun searchNovelResults(queryContent: String, result: Result) {
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
            mActivity!!.runOnUiThread {
                result.success(map)
            }
        }
    }

}
