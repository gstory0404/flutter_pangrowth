package com.example.flutter_pangrowth.video.view.draw_full

import android.app.Activity
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * @Author: gstory
 * @CreateDate: 2021/12/14 2:44 下午
 * @Description: 描述
 */

internal class DrawFullViewFactory (private val messenger: BinaryMessenger, private val activity: Activity) : PlatformViewFactory(
        StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val params = args as Map<String?, Any?>
        return DrawFullView(activity,messenger, viewId, params)
    }
}