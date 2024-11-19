package com.gstory.flutter_pangrowth.novel.pages

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.bytedance.sdk.djx.IDJXWidget
import com.bytedance.sdk.nov.api.NovSdk
import com.bytedance.sdk.nov.api.params.NovReaderConfig
import com.bytedance.sdk.nov.api.params.NovWidgetHomeParams
import com.gstory.flutter_pangrowth.R

/**
 * @Author: gstory
 * @CreateDate: 2024/11/19 16:09
 * @Description: java类作用描述
 */

class NovelAggregatePageActivity : AppCompatActivity() {

    private val TAG = NovelAggregatePageActivity::class.java.simpleName

    private var mIDPWidget: IDJXWidget? = null
    private var mDrawFragment: Fragment? = null

    override fun onPostCreate(savedInstanceState: Bundle?) {
        super.onPostCreate(savedInstanceState)
        setContentView(R.layout.activity_draw_video_full_screen)
        initDrawWidget()
        mDrawFragment = mIDPWidget!!.fragment
        supportFragmentManager.beginTransaction()
            .replace(R.id.draw_video_full_frame, mDrawFragment!!)
            .commitAllowingStateLoss()
    }

    private fun initDrawWidget() {
        mIDPWidget = NovSdk.factory()?.createStoryHome(NovWidgetHomeParams(NovReaderConfig()))
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