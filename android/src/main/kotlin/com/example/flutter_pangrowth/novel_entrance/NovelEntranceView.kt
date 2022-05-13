package com.example.flutter_pangrowth.novel_entrance

import android.app.Activity
import android.view.View
import android.widget.FrameLayout
import com.bytedance.novel.pangolin.NovelSDK
import com.bytedance.novel.pangolin.novelenterence.NovelEntranceConstants
import com.bytedance.novel.pangolin.novelenterence.view.BaseEntranceView
import com.example.flutter_pangrowth.utils.UIUtils
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

/**
 * @Author: gstory
 * @CreateDate: 2021/12/9 6:33 下午
 * @Description: 描述
 */


internal class NovelEntranceView(
        var activity: Activity,
        messenger: BinaryMessenger,
        id: Int,
        params: Map<String?, Any?>
) :
        PlatformView {

    private var mContainer: FrameLayout? = null
    private var viewWidth: Double = params["viewWidth"] as Double
    private var viewHeight: Double = params["viewHeight"] as Double
    private var type: String = params["type"] as String
    private var style: String = params["style"] as String

    init {
        mContainer = FrameLayout(activity)
        mContainer?.layoutParams?.width = (UIUtils.dip2px(activity, viewWidth.toFloat())).toInt()
        mContainer?.layoutParams?.height = (UIUtils.dip2px(activity, viewHeight.toFloat())).toInt()
        loadEntranceView()
    }

    override fun getView(): View {
        return mContainer!!
    }

    private fun loadEntranceView() {
        if (mContainer?.childCount!! > 0) {
            mContainer?.removeAllViews()
        }
        //金刚位
        if (type == "icon") {
            loadIcon()
            //悬浮球
        } else if (type == "floatBall") {
            loadFloatBall()
            //加载banner
        } else if (type == "banner") {
            loadBanner()
            //加载window
        } else if (type == "window") {
            loadWindow()
            //加载feed单本小说
        } else if (type == "feedSingle") {
            loadFeedSingle()
            //加载FeedLarge
        } else if (type == "feedList") {
            loadFeedList()
        }
    }

    /**
     * 加载金刚位置
     */
    private fun loadIcon() {
        val icon: BaseEntranceView = if (style == "circle") {
            NovelSDK.getIconView(activity, NovelEntranceConstants.IconType.CIRCLE)
        } else {
            NovelSDK.getIconView(activity, NovelEntranceConstants.IconType.RECT)
        }
        mContainer?.addView(icon)
        icon.show()
    }

    /**
     * 加载悬浮球
     */
    private fun loadFloatBall() {
        val floatBall: BaseEntranceView = if (style == "withClose") {
            NovelSDK.getFloatBallView(activity, NovelEntranceConstants.FloatBallType.WITH_CLOSE_ICON)
        } else {
            NovelSDK.getFloatBallView(activity, NovelEntranceConstants.FloatBallType.WITHOUT_CLOSE_ICON)
        }
        mContainer?.addView(floatBall)
        floatBall.show()
    }

    /**
     * 加载banner
     */
    private fun loadBanner() {
        val banner: BaseEntranceView = when (style) {
            "large" -> {
                NovelSDK.getBannerView(activity, NovelEntranceConstants.BannerType.SIXTEEN_NINE)
            }
            "medium" -> {
                NovelSDK.getBannerView(activity, NovelEntranceConstants.BannerType.SIXTEEN_FIVE)
            }
            else -> {
                NovelSDK.getBannerView(activity, NovelEntranceConstants.BannerType.SIXTEEN_THREE)
            }
        }
        mContainer?.addView(banner)
        banner.show()
    }

    /**
     * 加载window
     */
    private fun loadWindow() {
        val window: BaseEntranceView = if (style == "color1") {
            NovelSDK.getWindowView(activity, NovelEntranceConstants.WindowType.SIXTEEN_TEN)
        } else {
            NovelSDK.getWindowView(activity, NovelEntranceConstants.WindowType.TWO_ONE)
        }
        mContainer?.addView(window)
        window.show()
    }

    /**
     * 加载FeedSmall
     */
    private fun loadFeedSingle() {
        NovelSDK.getRecommendFeedNovel(1) {
            view.post {
                var feedStyle = when (style) {
                    "male" -> {
                        NovelEntranceConstants.FlowcardStyle.NORMAL
                    }
                    "female" -> {
                        NovelEntranceConstants.FlowcardStyle.FEMALE
                    }
                    else -> {
                        NovelEntranceConstants.FlowcardStyle.NORMAL
                    }
                }
                val window: BaseEntranceView = NovelSDK.getFlowcardView(activity,
                        NovelEntranceConstants.FlowcardType.SIXTEEN_NINE,
                        feedStyle,
                        it?.get(0)!!,
                        darkMode = false)
                mContainer?.addView(window)
                window.show()
            }
        }
    }

    /**
     * 加载FeedLarge
     */
    private fun loadFeedList() {
        NovelSDK.getRecommendFeedNovel(3) {
            view.post {
                it?.filterNotNull()?.let { arrayList ->
                    val window: BaseEntranceView = NovelSDK.getFlowcardViewV2(activity, arrayList, false)!!
                    mContainer?.addView(window)
                    window.show()
                }
            }
        }
    }

    override fun dispose() {
        mContainer?.removeAllViews()
    }
}