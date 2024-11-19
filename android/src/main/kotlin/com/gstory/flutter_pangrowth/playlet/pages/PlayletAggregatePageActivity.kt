package com.gstory.flutter_pangrowth.playlet.pages

import android.os.Bundle
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
import com.bytedance.sdk.djx.params.DJXWidgetDramaHomeParams
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
        detailConfig.hideTopInfo(false)
            .hideBottomInfo(false)
        val params = DJXWidgetDramaHomeParams.obtain(detailConfig)
            // 换一换功能是否打开
            .showBackBtn(true)
            // 是否展示标题栏
            .showPageTitle(true)
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