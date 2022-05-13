package com.example.flutter_pangrowth.video.view.single_video_card

import android.app.Activity
import android.graphics.Typeface
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.annotation.Nullable
import com.bytedance.sdk.dp.*
import com.example.flutter_pangrowth.VideoHolder
import com.example.flutter_pangrowth.utils.UIUtils
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

/**
 * @Author: gstory
 * @CreateDate: 2021/12/15 12:17 下午
 * @Description: 单视频
 */

internal class VideoSingleCardView(
        var activity: Activity,
        messenger: BinaryMessenger,
        id: Int,
        params: Map<String?, Any?>
) :
        PlatformView {

    private val TAG = VideoSingleCardView::class.java.simpleName

    private var mContainer: FrameLayout = FrameLayout(activity)
    private var viewWidth: Double = params["viewWidth"] as Double
    private var viewHeight: Double = params["viewHeight"] as Double

    private var mElement: IDPElement? = null

    init {
        mContainer.layoutParams?.width = (UIUtils.dip2px(activity, viewWidth.toFloat())).toInt()
        mContainer.layoutParams?.height = (UIUtils.dip2px(activity, viewHeight.toFloat())).toInt()
        loadVideoSingleCard()
    }

    override fun getView(): View {
        return mContainer
    }

    private fun loadVideoSingleCard() {
        val params = DPWidgetVideoSingleCardParams.obtain()
                .hidePlay(true) //隐藏播放按钮
                .hideTitle(false) //隐藏标题
                .coverWidth(UIUtils.dip2px(activity, viewWidth.toFloat())) // 图片宽度
                .coverHeight(UIUtils.dip2px(activity, viewHeight.toFloat())) // 图片高度
                .listener(object : IDPVideoSingleCardListener() {
                    override fun onDPClick(map: Map<String, Any>) {
                        Log.d(TAG, "onDPClick map = $map")
                    }

                    override fun onDPRequestStart(@Nullable map: Map<String, Any>?) {
                        Log.d(TAG, "onDPRequestStart")
                    }

                    override fun onDPRequestSuccess(list: List<Map<String, Any>>) {
                        if (list == null) {
                            return
                        }
                        for (i in list.indices) {
                            Log.d(TAG, "onDPRequestSuccess i = " + i + ", map = " + list[i].toString())
                        }
                    }

                    override fun onDPRequestFail(code: Int, msg: String, @Nullable map: Map<String, Any>?) {
                        if (map == null) {
                            Log.d(TAG, "onDPRequestFail code = $code, msg = $msg")
                            return
                        }
                        Log.d(TAG, "onDPRequestFail  code = $code, msg = $msg, map = $map")
                    }

                    override fun onDPClientShow(map: Map<String, Any>) {
                        Log.d(TAG, "onDPClientShow map = $map")
                    }

                    override fun onDPClickAuthorName(map: Map<String, Any>) {
                        Log.d(TAG, "onDPClickAuthorName map = $map")
                    }

                    override fun onDPClickAvatar(map: Map<String, Any>) {
                        Log.d(TAG, "onDPClickAvatar map = $map")
                    }

                    override fun onDPClickComment(map: Map<String, Any>) {
                        Log.d(TAG, "onDPClickComment map = $map")
                    }

                    override fun onDPClickLike(isLike: Boolean, map: Map<String, Any>) {
                        Log.d(TAG, "onDPClickLike isLike = $isLike, map = $map")
                    }

                    override fun onDPVideoPlay(map: Map<String, Any>) {
                        Log.d(TAG, "onDPVideoPlay map = $map")
                    }

                    override fun onDPVideoPause(map: Map<String, Any>) {
                        Log.d(TAG, "onDPVideoPause map = $map")
                    }

                    override fun onDPVideoContinue(map: Map<String, Any>) {
                        Log.d(TAG, "onDPVideoContinue map = $map")
                    }

                    override fun onDPVideoOver(map: Map<String, Any>) {
                        Log.d(TAG, "onDPVideoOver map = $map")
                    }

                    override fun onDPVideoCompletion(map: Map<String, Any>) {
                        Log.d(TAG, "onDPVideoCompletion map = $map")
                    }
                })

        VideoHolder.INSTANCE.loadVideoSingleCard(params, object : IDPWidgetFactory.Callback {
            override fun onError(code: Int, msg: String) {
                Log.d(TAG, "onError code = $code, msg = $msg")
            }

            override fun onSuccess(data: IDPElement) {
                if (data == null) {
                    return
                }
                mElement = data
                val view = data.view
                Log.d(TAG, "title = " + data.title) //获取标题
                if (view == null) {
                    return
                }
                mContainer.removeAllViews()
                mContainer.addView(view)
                mElement?.reportShow()
            }
        })
    }

    override fun dispose() {
        mElement?.destroy()
    }
}