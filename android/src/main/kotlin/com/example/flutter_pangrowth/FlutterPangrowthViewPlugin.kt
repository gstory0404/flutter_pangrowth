package com.example.flutter_pangrowth

import android.app.Activity
import com.example.flutter_pangrowth.novel_entrance.NovelEntranceViewFactory
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
    }
}