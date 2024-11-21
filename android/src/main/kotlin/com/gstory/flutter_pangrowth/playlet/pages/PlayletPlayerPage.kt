package com.gstory.flutter_pangrowth.playlet.pages

import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.view.View
import android.view.WindowManager
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.bytedance.sdk.djx.DJXSdk
import com.bytedance.sdk.djx.IDJXWidget
import com.bytedance.sdk.djx.interfaces.listener.IDJXDramaUnlockListener
import com.bytedance.sdk.djx.model.DJXDrama
import com.bytedance.sdk.djx.model.DJXDramaDetailConfig
import com.bytedance.sdk.djx.model.DJXDramaUnlockAdMode
import com.bytedance.sdk.djx.model.DJXDramaUnlockInfo
import com.bytedance.sdk.djx.model.DJXDramaUnlockMethod
import com.bytedance.sdk.djx.params.DJXWidgetDramaDetailParams
import com.drake.statusbar.immersive
import com.drake.statusbar.setActionBarTransparent
import com.gstory.flutter_pangrowth.R


/**
 * @Author: gstory
 * @CreateDate: 2024/11/19 19:02
 * @Description: 短剧播放
 */

class PlayletPlayerPage : AppCompatActivity() {

    private val TAG = PlayletPlayerPage::class.java.simpleName

    private var dpWidget: IDJXWidget? = null
    private var mDrawFragment: Fragment? = null

    var playletId: Long = 0L
    var index: Int = 0
    var freeCount: Int = 0
    var unlockCount: Int = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_draw_video_full_screen)
        setActionBarTransparent()
        immersive()
        playletId = intent.getLongExtra("playletId", 0L)
        index = intent.getIntExtra("index", 0)
        freeCount = intent.getIntExtra("freeCount", 0)
        unlockCount = intent.getIntExtra("unlockCount", 0)
        initDrawWidget()
        mDrawFragment = dpWidget!!.fragment
        supportFragmentManager.beginTransaction()
            .replace(R.id.draw_video_full_frame, mDrawFragment!!)
            .commitAllowingStateLoss()
    }

    private fun initDrawWidget() {
        var detailConfig = DJXDramaDetailConfig.obtain(DJXDramaUnlockAdMode.MODE_COMMON, freeCount, object :
            IDJXDramaUnlockListener {
            override fun unlockFlowEnd(
                drama: DJXDrama,
                errCode: IDJXDramaUnlockListener.UnlockErrorStatus?,
                map: Map<String, Any>?
            ) {

            }

            override fun unlockFlowStart(
                drama: DJXDrama,
                callback: IDJXDramaUnlockListener.UnlockCallback,
                map: Map<String, Any>?
            ) {
                val info = DJXDramaUnlockInfo(drama.id, unlockCount, DJXDramaUnlockMethod.METHOD_AD, false)
                callback.onConfirm(info)
            }
        }).apply {
            infiniteScrollEnabled(true) //是否开启无限下滑
            hideBack(false, null)//是否隐藏左上角关闭按钮
            hideTopInfo(false)//是否隐藏左上角集数
            hideBottomInfo(false)//hideBottomInfo
            hideLikeButton(false)//隐藏点赞按钮
            hideFavorButton(false)//隐藏收藏按钮
            hideRewardDialog(false)//是否隐藏SDK封装解锁弹窗
            hideMore(false)//是否隐藏SDK封装解锁弹窗
            hideCellularToast(false)//是否显示流量播放时提醒Toast
        }
        dpWidget = DJXSdk.factory().createDramaDetail(
            DJXWidgetDramaDetailParams.obtain(playletId, index, detailConfig)
        )
    }

    override fun onResume() {
        super.onResume()
        dpWidget?.fragment?.onResume()
    }

    override fun onPause() {
        super.onPause()
        dpWidget?.fragment?.onPause()
    }


    override fun onDestroy() {
        super.onDestroy()
        dpWidget?.destroy()
    }
}