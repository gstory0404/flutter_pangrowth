package com.example.flutter_pangrowth.video.view.video_card

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
 * @Description: 视频卡片
 */

internal class VideoCardView(
        var activity: Activity,
        messenger: BinaryMessenger,
        id: Int,
        params: Map<String?, Any?>
) :
        PlatformView {

    private val TAG = VideoCardView::class.java.simpleName

    private var mContainer: FrameLayout = FrameLayout(activity)
    private var viewWidth: Double = params["viewWidth"] as Double
    private var viewHeight: Double = params["viewHeight"] as Double

    private var mElement: IDPElement? = null

    init {
        mContainer.layoutParams?.width = (UIUtils.dip2px(activity, viewWidth.toFloat())).toInt()
        mContainer.layoutParams?.height = (UIUtils.dip2px(activity, viewHeight.toFloat())).toInt()
        loadVideoCard()
    }

    override fun getView(): View {
        return mContainer
    }

    private fun loadVideoCard() {
        val params = DPWidgetVideoCardParams.obtain()
                .hideTitle(false) //隐藏标题
//                .cardHeight(UIUtils.dip2px(activity, viewWidth.toFloat())) // 图片宽度
//                .cardHeight(UIUtils.dip2px(activity, viewHeight.toFloat()).toInt()) // 图片高度
                .cardHeight(150)
                .listener(object : IDPVideoCardListener() {
                    override fun onDPItemClick(map: Map<String?, Any?>) {
                        Log.d(TAG,"onDPItemClick map = $map")
                    }

                    override fun onDPLSwipeEnter() {
                        Log.d(TAG,"onDPLSwipeEnter")
                    }

                    override fun onDPRequestStart(@Nullable map: Map<String?, Any?>?) {
                        Log.d(TAG,"onDPRequestStart")
                    }

                    override fun onDPRequestSuccess(list: List<Map<String?, Any?>>?) {
                        if (list == null) {
                            return
                        }
                        for (i in list.indices) {
                            Log.d(TAG,"onDPRequestSuccess i = " + i + ", map = " + list[i].toString())
                        }
                    }

                    override fun onDPRequestFail(code: Int, msg: String, @Nullable map: Map<String?, Any?>?) {
                        if (map == null) {
                            Log.d(TAG,"onDPRequestFail code = $code, msg = $msg")
                            return
                        }
                        Log.d(TAG,"onDPRequestFail  code = $code, msg = $msg, map = $map")
                    }

                    override fun onDPClientShow(@Nullable map: Map<String?, Any?>?) {
                        Log.d(TAG,"onDPClientShow")
                    }

                    override fun onDPClickAuthorName(map: Map<String?, Any?>) {
                        Log.d(TAG,"onDPClickAuthorName map = $map")
                    }

                    override fun onDPClickAvatar(map: Map<String?, Any?>) {
                        Log.d(TAG,"onDPClickAvatar map = $map")
                    }

                    override fun onDPClickComment(map: Map<String?, Any?>) {
                        Log.d(TAG,"onDPClickComment map = $map")
                    }

                    override fun onDPClickLike(isLike: Boolean, map: Map<String?, Any?>) {
                        Log.d(TAG,"onDPClickLike isLike = $isLike, map = $map")
                    }

                    override fun onDPVideoPlay(map: Map<String?, Any?>) {
                        Log.d(TAG,"onDPVideoPlay map = $map")
                    }

                    override fun onDPVideoPause(map: Map<String?, Any?>) {
                        Log.d(TAG,"onDPVideoPause map = $map")
                    }

                    override fun onDPVideoContinue(map: Map<String?, Any?>) {
                        Log.d(TAG,"onDPVideoContinue map = $map")
                    }

                    override fun onDPVideoOver(map: Map<String?, Any?>) {
                        Log.d(TAG,"onDPVideoOver map = $map")
                    }

                    override fun onDPVideoCompletion(map: Map<String?, Any?>) {
                        Log.d(TAG,"onDPVideoCompletion map = $map")
                    }
                }).dislikeListener(activity, object :DPWidgetVideoCardParams.IDislikeListener {

                    override fun onSelected(p0: String?) {
                        // 如果 hideTitle 为 true，可以不做任何处理
                        Log.d(TAG,"dislike msg = $p0");
                        mContainer.removeAllViews()
                    }
                });

        VideoHolder.INSTANCE.loadCustomVideoCard(params, object : IDPWidgetFactory.Callback {
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