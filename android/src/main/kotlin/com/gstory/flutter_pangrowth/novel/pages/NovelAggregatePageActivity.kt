package com.gstory.flutter_pangrowth.novel.pages

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.bytedance.sdk.djx.IDJXWidget
import com.bytedance.sdk.nov.api.NovSdk
import com.bytedance.sdk.nov.api.iface.INovUnlockListener
import com.bytedance.sdk.nov.api.model.NovPage
import com.bytedance.sdk.nov.api.model.NovStory
import com.bytedance.sdk.nov.api.params.NovReaderConfig
import com.bytedance.sdk.nov.api.params.NovWidgetHomeParams
import com.gstory.flutter_pangrowth.R
import com.gstory.flutter_pangrowth.utils.NovelRewardUtils

/**
 * @Author: gstory
 * @CreateDate: 2024/11/19 16:09
 * @Description: java类作用描述
 */

class NovelAggregatePageActivity : AppCompatActivity() {

    private val TAG = NovelAggregatePageActivity::class.java.simpleName

    private var mIDPWidget: IDJXWidget? = null
    private var mDrawFragment: Fragment? = null
    var adCode: String = ""

    override fun onPostCreate(savedInstanceState: Bundle?) {
        super.onPostCreate(savedInstanceState)
        setContentView(R.layout.activity_draw_video_full_screen)
        adCode = intent.getStringExtra("adCode")?.toString() ?: ""
        initDrawWidget()
        mDrawFragment = mIDPWidget!!.fragment
        supportFragmentManager.beginTransaction()
            .replace(R.id.draw_video_full_frame, mDrawFragment!!)
            .commitAllowingStateLoss()
    }

    private fun initDrawWidget() {
        mIDPWidget = NovSdk.factory()?.createStoryHome(NovWidgetHomeParams(NovReaderConfig().apply {
            //广告模式 可以选自SDK直出广告 or 自定义广告
            rewardAdMode = NovReaderConfig.NovRewardAdMode.MODE_CUSTOM
            //文末推荐卡片样式
            endPageCardStyle = NovReaderConfig.NovEndPageCardStyle.STYLE_MIX
            //阅读器默认字体大小
            defaultTextSize = 16
            //阅读器默认翻页模式
            defaultPageTurnMode = NovReaderConfig.NovPageTurnMode.TURN_LEFT_RIGHT_SIMULATE
            //文末推荐页推荐个数，默认：3 个
            endPageRecSize = 3
            unlockListener = object : INovUnlockListener {
                override fun onUnlockEnd(
                    isSuccess: Boolean,
                    status: INovUnlockListener.UnlockErrorStatus?,
                    storyInfo: NovStory?,
                    pageInfo: NovPage?
                ) {

                }

                override fun onUnlockStart(storyInfo: NovStory, pageInfo: NovPage) {
                    Log.d("NovelPlugin","开始广告解锁")
                }

                override fun onShowCustomAd(callback: INovUnlockListener.CustomAdCallback) {
                    NovelRewardUtils.loadReward(this@NovelAggregatePageActivity,adCode,callback)
                }
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