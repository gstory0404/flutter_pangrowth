package com.gstory.flutter_pangrowth.playlet.pages

import android.os.Bundle
import android.widget.FrameLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.bytedance.sdk.djx.DJXSdk
import com.bytedance.sdk.djx.IDJXWidget
import com.bytedance.sdk.djx.interfaces.listener.IDJXAdListener
import com.bytedance.sdk.djx.interfaces.listener.IDJXDramaHomeListener
import com.bytedance.sdk.djx.interfaces.listener.IDJXDramaListener
import com.bytedance.sdk.djx.interfaces.listener.IDJXDramaUnlockListener
import com.bytedance.sdk.djx.model.DJXDrama
import com.bytedance.sdk.djx.model.DJXDramaDetailConfig
import com.bytedance.sdk.djx.model.DJXDramaUnlockAdMode
import com.bytedance.sdk.djx.model.DJXDramaUnlockInfo
import com.bytedance.sdk.djx.model.DJXDramaUnlockMethod
import com.bytedance.sdk.djx.params.DJXWidgetDramaHomeParams
import com.drake.statusbar.immersive
import com.drake.statusbar.setActionBarTransparent
import com.drake.statusbar.statusPadding
import com.gstory.flutter_pangrowth.R

/**
 * @Author: gstory
 * @CreateDate: 2024/11/19 16:58
 * @Description: java类作用描述
 */

class PlayletAggregatePageActivity : AppCompatActivity() {

    private val TAG = PlayletAggregatePageActivity::class.java.simpleName

    private var dpWidget: IDJXWidget? = null
    private var mDrawFragment: Fragment? = null
    var freeCount: Int = 0
    var unlockCount: Int = 0
    var isShowTitle: Boolean = true
    var isShowBackButton: Boolean = true

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_draw_video_full_screen)
        setActionBarTransparent()
        immersive(findViewById<FrameLayout>(R.id.draw_video_full_frame))
        freeCount = intent.getIntExtra("freeCount", 0)
        unlockCount = intent.getIntExtra("unlockCount", 0)
        isShowTitle = intent.getBooleanExtra("isShowTitle", true)
        isShowBackButton = intent.getBooleanExtra("isShowBackButton", true)
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
        })
        detailConfig.hideTopInfo(false)
            .hideBottomInfo(false)
        val params = DJXWidgetDramaHomeParams.obtain(detailConfig)
            // 换一换功能是否打开
            .showBackBtn(isShowBackButton)
            // 是否展示标题栏
            .showPageTitle(isShowTitle)
            // 是否展示返回按钮
            .showBackBtn(true)
            .listener(object  : IDJXDramaHomeListener() {

            })
        dpWidget = DJXSdk.factory().createDramaHome(params)
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