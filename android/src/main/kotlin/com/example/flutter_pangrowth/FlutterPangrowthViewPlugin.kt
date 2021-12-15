package com.example.flutter_pangrowth

import android.app.Activity
import com.example.flutter_pangrowth.novel_entrance.NovelEntranceViewFactory
import com.example.flutter_pangrowth.video.view.draw_full.DrawFullViewFactory
import com.example.flutter_pangrowth.video.view.banner.VideoBannerViewFactory
import com.example.flutter_pangrowth.video.view.bubble.VideoBubbleViewFactory
import com.example.flutter_pangrowth.video.view.single_news_card.VideoNewsSingleCardViewFactory
import com.example.flutter_pangrowth.video.view.single_video_card.VideoSingleCardViewFactory
import com.example.flutter_pangrowth.video.view.textchain.VideoTextChainViewFactory
import com.example.flutter_pangrowth.video.view.video_card.VideoCardViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin

/**
 * @Author: gstory
 * @CreateDate: 2021/12/9 6:31 下午
 * @Description: 描述
 */

object FlutterPangrowthViewPlugin {
    fun registerWith(binding: FlutterPlugin.FlutterPluginBinding, activity: Activity) {
        //注册小说导流入口
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_pangrowth/NovelEntranceView", NovelEntranceViewFactory(binding.binaryMessenger, activity))
        //注册小说导流入口
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_pangrowth/DrawFullView", DrawFullViewFactory(binding.binaryMessenger, activity))
        //注册视频组件Banner
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_pangrowth/VideoBannerView", VideoBannerViewFactory(binding.binaryMessenger, activity))
        //注册视频组件-文字链
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_pangrowth/VideoTextChainView", VideoTextChainViewFactory(binding.binaryMessenger, activity))
        //注册视频组件-气泡
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_pangrowth/VideoBubbleView", VideoBubbleViewFactory(binding.binaryMessenger, activity))
        //视频卡片 单视频
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_pangrowth/VideoSingleCardView", VideoSingleCardViewFactory(binding.binaryMessenger, activity))
        //视频卡片 单信息流
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_pangrowth/VideoNewsSingleCardView", VideoNewsSingleCardViewFactory(binding.binaryMessenger, activity))
        //视频卡片
        binding.platformViewRegistry.registerViewFactory("com.gstory.flutter_pangrowth/VideoCardView", VideoCardViewFactory(binding.binaryMessenger, activity))

    }
}