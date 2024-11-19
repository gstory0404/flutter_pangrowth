package com.gstory.flutter_pangrowth.playlet.pages

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.bytedance.sdk.djx.DJXSdk
import com.bytedance.sdk.djx.IDJXWidget
import com.bytedance.sdk.djx.interfaces.listener.IDJXDramaHomeListener
import com.bytedance.sdk.djx.interfaces.listener.IDJXDramaUnlockListener
import com.bytedance.sdk.djx.model.DJXDrama
import com.bytedance.sdk.djx.model.DJXDramaDetailConfig
import com.bytedance.sdk.djx.model.DJXDramaUnlockAdMode
import com.bytedance.sdk.djx.params.DJXWidgetDramaHomeParams
import com.bytedance.sdk.djx.params.DJXWidgetDrawParams
import com.gstory.flutter_pangrowth.R

/**
 * @Author: gstory
 * @CreateDate: 2024/11/19 19:02
 * @Description: 短剧播放
 */

class PlayletPlayerPage  : AppCompatActivity() {

    private val TAG = PlayletPlayerPage::class.java.simpleName

    private var dpWidget: IDJXWidget? = null
    private var mDrawFragment: Fragment? = null

    override fun onPostCreate(savedInstanceState: Bundle?) {
        super.onPostCreate(savedInstanceState)
        setContentView(R.layout.activity_draw_video_full_screen)
        initDrawWidget()
        mDrawFragment = dpWidget!!.fragment
        supportFragmentManager.beginTransaction()
            .replace(R.id.draw_video_full_frame, mDrawFragment!!)
            .commitAllowingStateLoss()
    }

    private fun initDrawWidget() {
        var detailConfig = DJXDramaDetailConfig.obtain(DJXDramaUnlockAdMode.MODE_COMMON, 5, object :
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

            }
        })
        dpWidget = DJXSdk.factory().createDraw(
            DJXWidgetDrawParams.obtain()
                .adOffset(0) //单位 dp，为 0 时可以不设置
                .drawContentType(DJXWidgetDrawParams.DRAW_CONTENT_TYPE_ONLY_DRAMA)
                .drawChannelType(DJXWidgetDrawParams.DRAW_CHANNEL_TYPE_RECOMMEND)
                .hideClose(true, null)
                .hideChannelName(true)
                .detailConfig(detailConfig)
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
//        dpWidget?.destroy()
    }
}