package com.example.flutter_pangrowth.video.view

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.FrameLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import com.example.flutter_pangrowth.R

/**
 * @Author: gstory
 * @CreateDate: 2021/12/14 2:53 下午
 * @Description: 描述
 */

class VideoShowView(context: Context, attrs: AttributeSet?) : FrameLayout(context, attrs) {

    private var view: View = LayoutInflater.from(context).inflate(R.layout.layout_showview, this)

    var frameLayout : FrameLayout? = null

    init {
//        frameLayout =  view.findViewById(R.id.video_frame)
    }
    public fun showFragment(fragment: Fragment){
        (context as AppCompatActivity).supportFragmentManager.beginTransaction()
                .replace(R.id.video_frame,fragment)
                .commitAllowingStateLoss()
    }

}