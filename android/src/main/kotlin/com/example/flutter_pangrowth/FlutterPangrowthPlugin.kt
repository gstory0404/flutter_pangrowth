package com.example.flutter_pangrowth

import android.app.Activity
import android.app.Application
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
    private var mFlutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mActivity = binding.activity
//        Log.e("FlutterUnionadPlugin->","onAttachedToActivity")
        FlutterPangrowthViewPlugin.registerWith(mFlutterPluginBinding!!, mActivity!!)
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
            NovelPlugin.registerNovel(applicationContext, call, result)
            //打开书城
        } else if (call.method == "openNovelPage") {
            NovelPlugin.openNovelPage(mActivity,result)
            //获取小说阅读历史记录
        } else if (call.method == "getNovelHistory") {
            val size = call.argument<Int>("size")
            NovelPlugin.getNovelHistory(mActivity, size!!, result)
        } else if (call.method == "getNovelRecommendV1") {
            val size = call.argument<Int>("size")
            NovelPlugin.getNovelRecommend(mActivity, size!!, result)
        } else if (call.method == "getNovelRecommendFeed") {
            val size = call.argument<Int>("size")
            NovelPlugin.getNovelRecommend(mActivity, size!!, result)
            //上报阅读历史展示，当获取了用户的阅读历史信息，展示的时候务必上报
        } else if (call.method == "reportRecentNovelShow") {
            NovelPlugin.reportRecentNovelShow(call, result)
            //上报阅读点击，当用户点击了阅读历史信息，务必上报
        } else if (call.method == "reportRecentNovelClick") {
            NovelPlugin.reportRecentNovelClick(call, result)
            //打开一个书籍的阅读页面或者详情页面（如果是阅读历史就会打开阅读页面，推荐书籍会打开详情页面）
        } else if (call.method == "openNovelPageWithConfig") {
            NovelPlugin.openNovelPageWithConfig(mActivity, call, result)
        } else if (call.method == "openNovelPageWithUrl") {
            NovelPlugin.openNovelPageWithUrl(mActivity, call, result)
            //获取小说阅读时长
        } else if (call.method == "getReadDuration") {
            result.success(NovelSDK.getNovelReadingDuration())
            //小说搜索Sug页
        } else if (call.method == "searchNovelSuggestions") {
            val queryContent = call.argument<String>("queryContent")
            NovelPlugin.searchNovelSuggestions(mActivity, queryContent!!, result)
            //小说搜索结果页
        } else if (call.method == "searchNovelResults") {
            val queryContent = call.argument<String>("queryContent")
            NovelPlugin.searchNovelResults(mActivity, queryContent!!, result)
            /**
             * 视频相关
             */
            //视频初始化初始化
        } else if (call.method == "registerVideo") {
            VideoPlugin.registerVideo(applicationContext as Application?, call, result)
            //打开沉浸式小视频 全屏样式
        } else if (call.method == "openDrawVideoFull") {
            VideoPlugin.openDrawVideoFull(mActivity,call)
            result.success(true)
            //打开宫格小视频 全屏样式
        } else if (call.method == "openGridVideo") {
            VideoPlugin.openGridVideo(mActivity,call)
            result.success(true)
            //打开新闻 多列表
        } else if (call.method == "openNewsTabs") {
            VideoPlugin.openNewsTabs(mActivity,call)
            result.success(true)
            //打开新闻 单列表
        } else if (call.method == "openNewsTabOne") {
            VideoPlugin.openNewsTabOne(mActivity,call)
            result.success(true)
            //打开个人主页
        } else if (call.method == "openUserCenter") {
            VideoPlugin.openUserCenter(mActivity,call)
            result.success(true)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
