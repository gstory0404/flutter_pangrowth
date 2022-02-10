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

class NewsTabsActivity : AppCompatActivity() {

    private val TAG = NewsTabsActivity::class.java.simpleName

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
        mIDPWidget = VideoHolder.INSTANCE.buildNewsTabsWidget(DPWidgetNewsParams.obtain()
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
                         Log.d(TAG,"onDPRequestStart map = " + (map?.toString()
                                ?: ""))
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

                    override fun onDPNewsLike(@Nullable map: Map<String, Any>?, @Nullable data: IDPNativeData?) {
                         Log.d(TAG,"onDPNewsLike data = $data, map = " + (map?.toString()
                                ?: ""))
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
                         Log.d(TAG,"onDPNewsFavor data = $data, map = " + (map?.toString()
                                ?: ""))
                        if (data == null) {
                            return
                        }
//                        if (data.isFavor) {
//                            NewsCache.getInstance().saveFavorNews(data)
//                        } else {
//                            NewsCache.getInstance().removeFavorNews(data)
//                        }
                    }

                    override fun onDPReportResult(isSucceed: Boolean, map: Map<String, Any>) {}
                    override fun onDPOtherView(secondaryPageType: DPSecondaryPageType, map: Map<String, Any>): View? {
                        return null
                    }

                    override fun onDPNewsOtherD(map: Map<String, Any>) {
                         Log.d(TAG,"onDPNewsOtherD map = $map")
                    }

                    override fun onDPNewsVideoDetailOrientation(map: Map<String, Any>) {
                         Log.d(TAG,"onDPNewsVideoDetailOrientation map = $map")
                    }

                    override fun onDPNewsFilter(list: List<Map<String, Any>>): List<Long>? {
                        return null
                    }

                    override fun onDPNewsDetailLoad() {
                         Log.d(TAG,"onDPNewsDetailLoad")
                    }

                    override fun onDPPageStateChanged(pageState: DPPageState) {
                         Log.d(TAG,"onDPPageStateChanged pageState = $pageState")
                    }

                    override fun onDPRefreshStart() {
                         Log.d(TAG,"onDPRefreshStart")
                    }

                    override fun onDPRelatedNewsClick(map: Map<String, Any>) {
                         Log.d(TAG,"onDPRelatedNewsClick map = $map")
                    }
                }).adListener(object : IDPAdListener() {
                    override fun onDPAdRequest(map: Map<String, Any>) {
                         Log.d(TAG,"onDPAdRequest map =  $map")
                    }

                    override fun onDPAdRequestSuccess(map: Map<String, Any>) {
                         Log.d(TAG,"onDPAdRequestSuccess map = $map")
                    }

                    override fun onDPAdRequestFail(code: Int, msg: String, map: Map<String, Any>) {
                         Log.d(TAG,"onDPAdRequestFail map = $map ,msg = $msg")
                    }

                    override fun onDPAdFillFail(map: Map<String, Any>) {
                         Log.d(TAG,"onDPAdFillFail map = $map")
                    }

                    override fun onDPAdShow(map: Map<String, Any>) {
                         Log.d(TAG,"onDPAdShow map = $map")
                    }

                    override fun onDPAdPlayStart(map: Map<String, Any>) {
                         Log.d(TAG,"onDPAdPlayStart map = $map")
                    }

                    override fun onDPAdPlayPause(map: Map<String, Any>) {
                         Log.d(TAG,"onDPAdPlayPause map = $map")
                    }

                    override fun onDPAdPlayContinue(map: Map<String, Any>) {
                         Log.d(TAG,"onDPAdPlayContinue map = $map")
                    }

                    override fun onDPAdPlayComplete(map: Map<String, Any>) {
                         Log.d(TAG,"onDPAdPlayComplete map = $map")
                    }

                    override fun onDPAdClicked(map: Map<String, Any>) {
                         Log.d(TAG,"onDPAdClicked map = $map")
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