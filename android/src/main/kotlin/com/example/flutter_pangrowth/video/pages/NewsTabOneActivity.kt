package com.example.flutter_pangrowth.video.pages

import android.os.Bundle
import android.util.Log
import android.view.View
import androidx.annotation.Nullable
import androidx.appcompat.app.AppCompatActivity
import com.bytedance.sdk.dp.*
import com.example.flutter_pangrowth.R
import com.example.flutter_pangrowth.VideoHolder

/**
 * @Author: gstory
 * @CreateDate: 2021/12/14 2:25 下午
 * @Description: 描述
 */

class NewsTabOneActivity : AppCompatActivity() {

    private val TAG = NewsTabOneActivity::class.java.simpleName

    private var mIDPWidget: IDPWidget? = null


    override fun onPostCreate(savedInstanceState: Bundle?) {
        super.onPostCreate(savedInstanceState)
        setContentView(R.layout.activity_draw_video_full_screen)
        //初始化 news 组件
        initNewsWidget()
        supportFragmentManager.beginTransaction()
                .replace(R.id.draw_video_full_frame, mIDPWidget!!.fragment)
                .commitAllowingStateLoss()
    }

    private fun initNewsWidget() {
        mIDPWidget = VideoHolder.INSTANCE.buildNewsOneTabWidget(DPWidgetNewsParams.obtain()
                .showRefreshAnim(false)
                .channelCategory("__all__")
                .listener(object : IDPNewsListener() {
                    override fun onDPRefreshFinish() {
                         Log.d(TAG,"onDPRefreshFinish")
                    }

                    override fun onDPNewsItemClick(map: Map<String, Any>) {
                         Log.d(TAG,"onDPNewsItemClick map = $map")
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

                    override fun onDPNewsDetailEnter(map: Map<String, Any>) {
                         Log.d(TAG,"onDPNewsDetailEnter map = $map")
                    }

                    override fun onDPNewsDetailExit(map: Map<String, Any>) {
                         Log.d(TAG,"onDPNewsDetailExit map = $map")
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

                    override fun onDPNewsScrollTop(@Nullable map: Map<String, Any>?) {
                         Log.d(TAG,"onDPNewsScrollTop")
                    }

                    override fun onDPNewsLike(@Nullable map: Map<String, Any>?, @Nullable data: IDPNativeData?) {
                         Log.d(TAG,"onDPNewsLike data = $data")
                        if (data == null) {
                            return
                        }
//                        if (data.isLike) {
//                            NewsCache.getInstance().saveLikeNews(data)
//                        } else {
//                            NewsCache.getInstance().removeLikeNews(data)
//                        }
                    }

                    override fun onDPNewsFavor(@Nullable map: Map<String, Any>?, @Nullable data: IDPNativeData?) {
                         Log.d(TAG,"onDPNewsFavor data = $data")
                        if (data == null) {
                            return
                        }
//                        if (data.isFavor) {
//                            NewsCache.getInstance().saveFavorNews(data)
//                        } else {
//                            NewsCache.getInstance().removeFavorNews(data)
//                        }
                    }

                    override fun onDPNewsFilter(list: List<Map<String, Any>>): List<Long>? {
                        return null
                    }
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