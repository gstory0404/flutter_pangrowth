package com.gstory.flutter_pangrowth

import android.app.Activity
import android.app.Application
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.bytedance.sdk.openadsdk.TTAdConfig
import com.bytedance.sdk.openadsdk.TTAdSdk
import com.gstory.flutter_pangrowth.NovelPlugin
import com.gstory.flutter_pangrowth.PlayletPlugin

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


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
        //广告初始化
        if (call.method == "registerAd") {
            val androidAppId = (call.arguments as Map<String?, Any?>)["androidAppId"] as String
            TTAdSdk.init(mActivity, TTAdConfig.Builder().appId(androidAppId).build())
            TTAdSdk.start(object : TTAdSdk.Callback {
                override fun success() {
                    Log.d("TTAdSdk","广告初始化成功")
                    result.success(true)
                }

                override fun fail(code: Int, msg: String?) {
                    Log.d("TTAdSdk","广告初始化失败")
                    result.success(false)
                }
            })
            /**
             * 小说相关
             */
            //小说初始化
        } else if (call.method == "registerNovel") {
            NovelPlugin.registerNovel(applicationContext, call, result)
            //打开小说聚合页
        } else if (call.method == "openNovelAggregatePage") {
            NovelPlugin.openNovelAggregatePage(mActivity, call, result)
            //打开小说
        } else if (call.method == "openMiniStory") {
            NovelPlugin.openMiniStory(mActivity, result, call.arguments as Map<String?, Any?>)
            //查询短故事类目列表
        } else if (call.method == "requestNovelCategoryList") {
            NovelPlugin.requestNovelCategoryList(mActivity, result, call.arguments as Map<String?, Any?>)
            //根据搜索关键词获取短剧列表
        } else if (call.method == "requestStoryListWithSearchWord") {
            NovelPlugin.requestStoryListWithSearchWord(mActivity, result, call.arguments as Map<String?, Any?>)
            //短故事按照book_id查询
        } else if (call.method == "requestStoryListWithBookId") {
            NovelPlugin.requestStoryListWithBookId(mActivity, result, call.arguments as Map<String?, Any?>)
            //短故事分页加载
        } else if (call.method == "requestAllStoryListPage") {
            NovelPlugin.requestAllStoryListPage(mActivity, result, call.arguments as Map<String?, Any?>)
            //根据类目id查询短故事列表
        } else if (call.method == "requestCategoryStoryListWithCategoryId") {
            NovelPlugin.requestCategoryStoryListWithCategoryId(mActivity, result, call.arguments as Map<String?, Any?>)
            //短小说阅读记录
        } else if (call.method == "requestHistoryStoryList") {
            NovelPlugin.requestHistoryStoryList(mActivity, result, call.arguments as Map<String?, Any?>)
            //短小说收藏
        } else if (call.method == "requestCollectStory") {
            NovelPlugin.requestCollectStory(mActivity, result, call.arguments as Map<String?, Any?>)
            //短小说取消收藏
        } else if (call.method == "requestCancelCollectStory") {
            NovelPlugin.requestCancelCollectStory(mActivity, result, call.arguments as Map<String?, Any?>)
            //短小说收藏列表
        } else if (call.method == "requestStoryCollectionList") {
            NovelPlugin.requestStoryCollectionList(mActivity, result, call.arguments as Map<String?, Any?>)
            /**
             * 视频相关
             */
            //视频初始化初始化
        } else if (call.method == "registerVideo") {
            VideoPlugin.registerVideo(applicationContext as Application?, call, result)
            //打开沉浸式小视频 全屏样式
        } else if (call.method == "openDrawVideoFull") {
            VideoPlugin.openDrawVideoFull(mActivity, call)
            result.success(true)
            //打开宫格小视频 全屏样式
        } else if (call.method == "openGridVideo") {
            VideoPlugin.openGridVideo(mActivity, call)
            result.success(true)
            //打开新闻 多列表
        } else if (call.method == "openNewsTabs") {
            VideoPlugin.openNewsTabs(mActivity, call)
            result.success(true)
            //打开新闻 单列表
        } else if (call.method == "openNewsTabOne") {
            VideoPlugin.openNewsTabOne(mActivity, call)
            result.success(true)
            //打开个人主页
        } else if (call.method == "openUserCenter") {
            VideoPlugin.openUserCenter(mActivity, call)
            result.success(true)
            /**
             * 短剧相关
             */
            //短剧注册
        } else if (call.method == "registerPlaylet") {
            PlayletPlugin.registerPlaylet(mActivity, call, result)
            //打开短剧聚合页
        } else if (call.method == "openPlayletAggregatePage") {
            PlayletPlugin.openPlayletAggregatePage(mActivity, call, result)
            //进入播放器
        } else if (call.method == "enterPlayletPlayer") {
            PlayletPlugin.enterPlayletPlayer(mActivity, result, call.arguments as Map<String?, Any?>)
            //分页拉取所有短剧
        } else if (call.method == "requestAllPlayletListPage") {
            PlayletPlugin.requestAllPlayletListPage(mActivity, result, call.arguments as Map<String?, Any?>)
            //分页拉取推荐短剧
        } else if (call.method == "requestRecommendedPlayletListPage") {
            PlayletPlugin.requestRecommendedPlayletListPage(mActivity, result, call.arguments as Map<String?, Any?>)
            //根据短剧id获取短剧信息
        } else if (call.method == "requestPlayletListWithPlayletId") {
            PlayletPlugin.requestPlayletListWithPlayletId(mActivity, result, call.arguments as Map<String?, Any?>)
            //根据搜索关键词获取短剧列表
        } else if (call.method == "requestCategoryPlayletLisWithSearchWord") {
            PlayletPlugin.requestCategoryPlayletLisWithSearchWord(mActivity, result, call.arguments as Map<String?, Any?>)
            //获取分类列表
        } else if (call.method == "requestPlayletCategoryList") {
            PlayletPlugin.requestPlayletCategoryList(mActivity, result, call.arguments as Map<String?, Any?>)
            //根据分类获取列表
        } else if (call.method == "requestCategoryPlayletLisWithCategory") {
            PlayletPlugin.requestCategoryPlayletLisWithCategory(mActivity, result, call.arguments as Map<String?, Any?>)
            //短剧播放记录
        } else if (call.method == "requestPlayletHistoryListWithPage") {
            PlayletPlugin.requestPlayletHistoryListWithPage(mActivity, result, call.arguments as Map<String?, Any?>)
            //清理播放记录
        } else if (call.method == "requestPlayletHistoryClean") {
            PlayletPlugin.requestPlayletHistoryClean(mActivity, result, call.arguments as Map<String?, Any?>)
            //短剧点赞
        } else if (call.method == "likeShortplay") {
            PlayletPlugin.likeShortplay(mActivity, result, call.arguments as Map<String?, Any?>,true)
            //短剧取消点赞
        } else if (call.method == "cancelLikeShortplay") {
            PlayletPlugin.likeShortplay(mActivity, result, call.arguments as Map<String?, Any?>,false)
            //短剧收藏
        } else if (call.method == "collectShortplay") {
            PlayletPlugin.collectShortplay(mActivity, result, call.arguments as Map<String?, Any?>,true)
            //短剧取消收藏
        } else if (call.method == "cancelCollectShortplay") {
            PlayletPlugin.collectShortplay(mActivity, result, call.arguments as Map<String?, Any?>,false)
            //短剧收藏列表
        } else if (call.method == "requestCollectionList") {
            PlayletPlugin.requestCollectionList(mActivity, result, call.arguments as Map<String?, Any?>)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
