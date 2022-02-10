package com.example.flutter_pangrowth

import android.app.Activity
import android.app.Application
import android.content.Intent
import com.example.flutter_pangrowth.video.pages.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * @Author: gstory
 * @CreateDate: 2021/12/13 3:44 下午
 * @Description: 描述
 */

object VideoPlugin {
    /**
     * 短视频注册
     */
    fun registerVideo(context: Application?, call: MethodCall, result: MethodChannel.Result) {
        VideoHolder.INSTANCE.initSDK(context!!,call,result)
    }

    /**
     * 打开沉浸式小视频 全屏样式
     */
    fun openDrawVideoFull(activity: Activity?, call: MethodCall) {
        activity?.startActivity(Intent(activity, DrawVideoFullScreenActivity::class.java))
    }

    /**
     * 打开宫格小视频 全屏样式
     */
    fun openGridVideo(activity: Activity?, call: MethodCall) {
        activity?.startActivity(Intent(activity, GridVideoActivity::class.java))
    }

    /**
     * 打开新闻 多列表
     */
    fun openNewsTabs(activity: Activity?, call: MethodCall) {
        activity?.startActivity(Intent(activity, NewsTabsActivity::class.java))
    }

    /**
     * 打开新闻 单列表
     */
    fun openNewsTabOne(activity: Activity?, call: MethodCall) {
        activity?.startActivity(Intent(activity, NewsTabOneActivity::class.java))
    }

    /**
     * 打开个人中心
     */
    fun openUserCenter(activity: Activity?, call: MethodCall) {
        activity?.startActivity(Intent(activity, UserCenterActivity::class.java))
    }


}