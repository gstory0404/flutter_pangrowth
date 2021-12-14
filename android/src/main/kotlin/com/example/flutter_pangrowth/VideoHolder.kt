package com.example.flutter_pangrowth

import android.app.Application
import com.bytedance.sdk.dp.*
import io.flutter.plugin.common.MethodChannel

class VideoHolder private constructor() {
    companion object {
        val INSTANCE: VideoHolder by lazy(mode = LazyThreadSafetyMode.SYNCHRONIZED) {
            VideoHolder()
        }
    }

    fun initSDK(context: Application,result: MethodChannel.Result) {
        val configBuilder = DPSdkConfig.Builder()
                .debug(true)
                .needInitAppLog(false)
                .initListener { isSuccess -> //注意：1如果您的初始化没有放到application，请确保使用时初始化已经成功
                    result.success(isSuccess)
                } //接入了红包功能需要传入的参数，没有接入的话可以忽略该配置
                .luckConfig(DPSdkConfig.LuckConfig().application(context!!).enableLuck(false))
        DPSdk.init(context!!, "pangrowthconfig.json", configBuilder.build())
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
}