package com.example.flutter_pangrowth.video.view.draw_full

import android.app.Activity
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import androidx.annotation.Nullable
import com.bytedance.sdk.dp.DPWidgetDrawParams
import com.bytedance.sdk.dp.IDPAdListener
import com.bytedance.sdk.dp.IDPDrawListener
import com.bytedance.sdk.dp.IDPWidget
import com.example.flutter_pangrowth.VideoHolder
import com.example.flutter_pangrowth.utils.UIUtils
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

/**
 * @Author: gstory
 * @CreateDate: 2021/12/14 2:44 下午
 * @Description: 描述
 */

internal class DrawFullView(
        var activity: Activity,
        messenger: BinaryMessenger,
        id: Int,
        params: Map<String?, Any?>
) :
        PlatformView {

    private val TAG = DrawFullView::class.java.simpleName

    private var mContainer: FrameLayout? = null
    private var viewWidth: Double = params["viewWidth"] as Double
    private var viewHeight: Double = params["viewHeight"] as Double

    private var mIDPWidget: IDPWidget? = null

    init {
        //初始化 grid 组件
        initDrawWidget()
        mContainer = FrameLayout(activity)
        mContainer?.layoutParams?.width = (UIUtils.dip2px(activity, viewWidth.toFloat())).toInt()
        mContainer?.layoutParams?.height = (UIUtils.dip2px(activity, viewHeight.toFloat())).toInt()
    }


    override fun getView(): View {
        return mContainer!!
    }

    private fun initDrawWidget() {
        mIDPWidget = VideoHolder.INSTANCE.buildDrawWidget(DPWidgetDrawParams.obtain()
//                .liveAdCodeId("946413486").liveNativeAdCodeId("946413492")
                .adOffset(0) //单位 dp，为 0 时可以不设置
                .hideClose(false, null)
                .listener(object : IDPDrawListener() {
                    override fun onDPRefreshFinish() {
                        Log.d(TAG,"onDPRefreshFinish")
                    }

                    override fun onDPPageChange(position: Int) {
                        Log.d(TAG,"onDPPageChange: $position")
                    }

                    override fun onDPPageChange(position: Int, map: Map<String, Any>) {
                        if (map == null) {
                            return
                        }
                        Log.d(TAG,"onDPPageChange: $position, map = $map")
                    }

                    override fun onDPVideoPlay(map: Map<String, Any>) {
                        Log.d(TAG,"onDPVideoPlay map = $map")
                    }

                    override fun onDPVideoOver(map: Map<String, Any>) {
                        Log.d(TAG,"onDPVideoOver map = $map")
                    }

                    override fun onDPVideoCompletion(map: Map<String, Any>) {
                        Log.d(TAG,"onDPVideoCompletion map = $map")
                    }

                    override fun onDPClose() {
                        Log.d(TAG,"onDPClose")
                    }

                    override fun onDPReportResult(isSucceed: Boolean) {
                        Log.d(TAG,"onDPReportResult isSucceed = $isSucceed")
                    }

                    override fun onDPReportResult(isSucceed: Boolean, map: Map<String, Any>) {
                        Log.d(TAG,"onDPReportResult isSucceed = $isSucceed, map = $map")
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

                    override fun onDPVideoPause(map: Map<String, Any>) {
                        Log.d(TAG,"onDPVideoPause map = $map")
                    }

                    override fun onDPVideoContinue(map: Map<String, Any>) {
                        Log.d(TAG,"onDPVideoContinue map = $map")
                    }
                }).adListener(object : IDPAdListener() {
                    override fun onDPAdRequest(map: Map<String, Any>) {
                        Log.d(TAG,"onDPAdRequest map =  $map")
                    }

                    override fun onDPAdRequestSuccess(map: Map<String, Any>) {
                        Log.d(TAG,"onDPAdRequestSuccess map = $map")
                    }

                    override fun onDPAdRequestFail(code: Int, msg: String, map: Map<String, Any>) {
                        Log.d(TAG,"onDPAdRequestFail map = $map")
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


    override fun dispose() {
        mIDPWidget?.destroy()
    }
}