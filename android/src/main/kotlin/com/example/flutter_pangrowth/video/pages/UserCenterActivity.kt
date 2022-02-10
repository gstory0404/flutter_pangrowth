package com.example.flutter_pangrowth.video.pages

import android.os.Bundle
import android.util.Log
import androidx.annotation.Nullable
import androidx.appcompat.app.AppCompatActivity
import com.bytedance.sdk.dp.DPSdk
import com.bytedance.sdk.dp.DPWidgetUserProfileParam
import com.bytedance.sdk.dp.IDPDrawListener
import com.bytedance.sdk.dp.IDPWidget
import com.example.flutter_pangrowth.R

/**
 * @Author: gstory
 * @CreateDate: 2022/2/10 11:21 上午
 * @Description: 个人主页
 */

class UserCenterActivity : AppCompatActivity() {
    private val TAG = UserCenterActivity::class.java.simpleName

    private var mIDPWidget: IDPWidget? = null

    override fun onPostCreate(savedInstanceState: Bundle?) {
        super.onPostCreate(savedInstanceState)
        setContentView(R.layout.activity_draw_video_full_screen)
        //初始化 user主页 组件
        initUserWidget()
        supportFragmentManager.beginTransaction()
            .replace(R.id.draw_video_full_frame, mIDPWidget!!.fragment)
            .commitAllowingStateLoss()
    }

    private fun initUserWidget() {
        mIDPWidget = DPSdk.factory()
            .create(DPWidgetUserProfileParam.get().listener(object : IDPDrawListener() {
                override fun onDPRefreshFinish() {
                    Log.d(TAG,"onDPRefreshFinish")
                }

                override fun onDPPageChange(position: Int) {
                    Log.d(TAG,"onDPPageChange: $position")
                }

                override fun onDPVideoPlay(map: Map<String, Any>) {
                    Log.d(TAG,"onDPVideoPlay")
                }

                override fun onDPVideoCompletion(map: Map<String, Any>) {
                    Log.d(TAG,"onDPVideoCompletion: ")
                }

                override fun onDPVideoOver(map: Map<String, Any>) {
                    Log.d(TAG,"onDPVideoOver")
                }

                override fun onDPClose() {
                    Log.d(TAG,"onDPClose")
                }

                override fun onDPReportResult(isSucceed: Boolean) {
                    Log.d(TAG,"onDPReportResult")
                }

                override fun onDPReportResult(isSucceed: Boolean, map: Map<String, Any>) {
                    Log.d(TAG,"onDPReportResult")
                }

                override fun onDPRequestStart(@Nullable map: Map<String, Any>?) {
                    Log.d(TAG,"onDPRequestStart")
                }

                override fun onDPRequestSuccess(list: List<Map<String, Any>>) {
                    Log.d(TAG,"onDPRequestSuccess")
                }

                override fun onDPRequestFail(
                    code: Int,
                    msg: String,
                    @Nullable map: Map<String, Any>?
                ) {
                    Log.d(TAG,"onDPRequestFail")
                }

                override fun onDPClickAuthorName(map: Map<String, Any>) {
                    Log.d(TAG,"onDPClickAuthorName")
                }

                override fun onDPClickAvatar(map: Map<String, Any>) {
                    Log.d(TAG,"onDPClickAvatar")
                }

                override fun onDPClickComment(map: Map<String, Any>) {
                    Log.d(TAG,"onDPClickComment")
                }

                override fun onDPClickLike(isLike: Boolean, map: Map<String, Any>) {
                    Log.d(TAG,"onDPClickLike")
                }

                override fun onDPVideoPause(map: Map<String, Any>) {
                    Log.d(TAG,"onDPVideoPause")
                }

                override fun onDPVideoContinue(map: Map<String, Any>) {
                    Log.d(TAG,"onDPVideoContinue")
                }
            }))
    }

    override fun onResume() {
        super.onResume()
        mIDPWidget?.fragment?.onResume()
    }

    override fun onPause() {
        super.onPause()
        mIDPWidget?.fragment?.onResume()
    }

    override fun onDestroy() {
        super.onDestroy()
        mIDPWidget?.destroy()
    }
}