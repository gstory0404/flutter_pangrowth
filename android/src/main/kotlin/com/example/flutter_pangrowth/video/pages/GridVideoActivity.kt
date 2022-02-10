package com.example.flutter_pangrowth.video.pages

import android.os.Bundle
import android.util.Log
import androidx.annotation.Nullable
import androidx.appcompat.app.AppCompatActivity
import com.bytedance.sdk.dp.DPWidgetGridParams
import com.bytedance.sdk.dp.IDPGridListener
import com.bytedance.sdk.dp.IDPWidget
import com.example.flutter_pangrowth.R
import com.example.flutter_pangrowth.VideoHolder

/**
 * @Author: gstory
 * @CreateDate: 2021/12/14 2:25 下午
 * @Description: 描述
 */

class GridVideoActivity : AppCompatActivity() {

    private val TAG = GridVideoActivity::class.java.simpleName

    private var mIDPWidget: IDPWidget? = null


    override fun onPostCreate(savedInstanceState: Bundle?) {
        super.onPostCreate(savedInstanceState)
        setContentView(R.layout.activity_draw_video_full_screen)
        //初始化 grid 组件
        initGridWidget()
        supportFragmentManager.beginTransaction()
                .replace(R.id.draw_video_full_frame, mIDPWidget!!.fragment)
                .commitAllowingStateLoss()
    }

    private fun initGridWidget() {
        mIDPWidget = VideoHolder.INSTANCE.buildGridWidget(DPWidgetGridParams.obtain()
                .listener(object : IDPGridListener() {
                    override fun onDPRefreshFinish() {
                        Log.d(TAG,"onDPRefreshFinish")
                    }

                    override fun onDPGridItemClick(map: Map<String, Any>) {
                        Log.d(TAG,"onDPGridItemClick map = $map")
                    }

                    override fun onDPRequestStart(@Nullable map: Map<String, Any>?) {
                        Log.d(TAG,"onDPRequestStart")
                    }

                    override fun onDPRequestSuccess(list: List<Map<String, Any>>) {
                        if (list == null) {
                            return
                        }
                        for (i in list.indices) {
                            Log.d(TAG,"onDPRequestSuccess i = " + i + ", map = " + list[i].toString())
                        }
                    }

                    override fun onDPRequestFail(code: Int, msg: String, @Nullable map: Map<String, Any>?) {
                        if (map == null) {
                            Log.d(TAG,"onDPRequestFail code = $code, msg = $msg")
                            return
                        }
                        Log.d(TAG,"onDPRequestFail  code = $code, msg = $msg, map = $map")
                    }

                    override fun onDPClientShow(@Nullable map: Map<String, Any>?) {
                        Log.d(TAG,"onDPClientShow")
                    }

                    override fun onDPClickAuthorName(map: Map<String, Any>) {
                        Log.d(TAG,"onDPClickAuthorName map = $map")
                    }

                    override fun onDPClickAvatar(map: Map<String, Any>) {
                        Log.d(TAG,"onDPClickAvatar map = $map")
                    }

                    override fun onDPClickComment(map: Map<String, Any>) {
                        Log.d(TAG,"onDPClickComment map = $map")
                    }

                    override fun onDPClickLike(isLike: Boolean, map: Map<String, Any>) {
                        Log.d(TAG,"onDPClickLike isLike = $isLike, map = $map")
                    }

                    override fun onDPVideoPlay(map: Map<String, Any>) {
                        Log.d(TAG,"onDPVideoPlay map = $map")
                    }

                    override fun onDPVideoPause(map: Map<String, Any>) {
                        Log.d(TAG,"onDPVideoPause map = $map")
                    }

                    override fun onDPVideoContinue(map: Map<String, Any>) {
                        Log.d(TAG,"onDPVideoContinue map = $map")
                    }

                    override fun onDPVideoOver(map: Map<String, Any>) {
                        Log.d(TAG,"onDPVideoOver map = $map")
                    }

                    override fun onDPVideoCompletion(map: Map<String, Any>) {
                        Log.d(TAG,"onDPVideoCompletion map = $map")
                    }

                    override fun onDPReportResult(isSucceed: Boolean, map: Map<String, Any>) {}
                }))
    }

    override fun onResume() {
        super.onResume()
        mIDPWidget?.fragment?.onResume()
    }

    override fun onPause() {
        super.onPause()
        mIDPWidget?.fragment?.onPause()
    }

    override fun onDestroy() {
        super.onDestroy()
        mIDPWidget?.destroy()
    }

}