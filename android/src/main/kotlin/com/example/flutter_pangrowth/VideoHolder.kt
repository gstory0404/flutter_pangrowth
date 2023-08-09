package com.example.flutter_pangrowth

import android.app.Application
import android.util.Log
import com.bytedance.sdk.dp.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class VideoHolder private constructor() {
    companion object {
        val INSTANCE: VideoHolder by lazy(mode = LazyThreadSafetyMode.SYNCHRONIZED) {
            VideoHolder()
        }
    }

    fun initSDK(context: Application, call: MethodCall, result: MethodChannel.Result) {
        val debug = call.argument<Boolean>("debug") as Boolean
        val configBuilder = DPSdkConfig.Builder()
            .debug(debug)
            //接入了红包功能需要传入的参数，没有接入的话可以忽略该配置
            .luckConfig(DPSdkConfig.LuckConfig().application(context).enableLuck(false))
        DPSdk.init(context, "pangrowthconfig.json", configBuilder.build())
        DPSdk.start { isSuccess, message ->
            run {
                Log.d("flutter_pangrowth初始化", message)
                result.success(isSuccess)
            }
        }
    }


    private fun getFactory(): IDPWidgetFactory {
        //一定要初始化后才能调用，否则会发生异常问题
        return DPSdk.factory()
    }

    fun buildDrawWidget(params: DPWidgetDrawParams?): IDPWidget? {
        //创建draw视频流组件
        return getFactory().createDraw(params)
    }


    fun buildGridWidget(params: DPWidgetGridParams?): IDPWidget? {
        //创建宫格组件
        return getFactory().createGrid(params)
    }

    fun buildNewsTabsWidget(params: DPWidgetNewsParams?): IDPWidget? {
        //创建多频道新闻组件
        return getFactory().createNewsTabs(params)
    }

    fun buildNewsOneTabWidget(params: DPWidgetNewsParams?): IDPWidget? {
        //创建单列表新闻组件
        return getFactory().createNewsOneTab(params)
    }

    fun loadBanner(params: DPWidgetBannerParams?, callback: IDPWidgetFactory.Callback?) {
        //视频组件-banner
        getFactory().loadBanner(params, callback)
    }

    fun loadTextChain(params: DPWidgetTextChainParams?, callback: IDPWidgetFactory.Callback?) {
        //视频组件-文字链
        getFactory().loadTextChain(params, callback)
    }

    fun loadBubble(params: DPWidgetBubbleParams?, callback: IDPWidgetFactory.Callback?) {
        //视频组件-气泡
        getFactory().loadBubble(params, callback)
    }

    fun loadVideoSingleCard(
        params: DPWidgetVideoSingleCardParams?,
        callback: IDPWidgetFactory.Callback?
    ) {
        //视频卡片-单视频
        getFactory().loadVideoSingleCard(params, callback)
    }

    fun loadVideoSingleCard4News(
        params: DPWidgetVideoSingleCardParams?,
        callback: IDPWidgetFactory.Callback?
    ) {
        //视频卡片-单新闻
        getFactory().loadVideoSingleCard4News(params, callback)
    }

    fun loadVideoCard(params: DPWidgetVideoCardParams?, callback: IDPWidgetFactory.Callback?) {
        getFactory().loadVideoCard(params, callback)
    }

    fun loadCustomVideoCard(
        params: DPWidgetVideoCardParams?,
        callback: IDPWidgetFactory.Callback?
    ) {
        //视频卡片
        getFactory().loadCustomVideoCard(params, callback)
    }
}