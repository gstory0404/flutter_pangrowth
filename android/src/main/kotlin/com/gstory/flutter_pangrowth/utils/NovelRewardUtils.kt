package com.gstory.flutter_pangrowth.utils

import android.app.Activity
import android.os.Bundle
import com.bytedance.sdk.nov.api.NovRewardAdResult
import com.bytedance.sdk.nov.api.iface.INovUnlockListener
import com.bytedance.sdk.openadsdk.AdSlot
import com.bytedance.sdk.openadsdk.TTAdLoadType
import com.bytedance.sdk.openadsdk.TTAdNative
import com.bytedance.sdk.openadsdk.TTAdSdk
import com.bytedance.sdk.openadsdk.TTRewardVideoAd

/**
 * @Author: gstory
 * @CreateDate: 2024/11/21 14:03
 * @Description: java类作用描述
 */

object NovelRewardUtils {
    /**
     * 短小说 加载激励广告解锁
     */
    fun loadReward(activity:Activity, adCode:String,callback: INovUnlockListener.CustomAdCallback){
        val adSlot = AdSlot.Builder()
            .setCodeId(adCode) // 广告代码位Id
            .setAdLoadType(TTAdLoadType.LOAD) // 本次广告用途：TTAdLoadType.LOAD实时；TTAdLoadType.PRELOAD预请求
            .build()

        TTAdSdk.getAdManager()
            .createAdNative(activity)
            .loadRewardVideoAd(adSlot, object : TTAdNative.RewardVideoAdListener {
                override fun onError(p0: Int, p1: String?) {}

                override fun onRewardVideoAdLoad(ad: TTRewardVideoAd?) {
                    ad?.apply {
                        setRewardAdInteractionListener(object :
                            TTRewardVideoAd.RewardAdInteractionListener {
                            override fun onAdShow() {
                                callback.onShow("") // CSJ cpm 不对外，可以参考 GroMore getShowEcpm 方法获取
                            }

                            override fun onAdVideoBarClick() {
                                // 广告点击
                            }

                            override fun onAdClose() {
                                // 广告关闭
                            }

                            override fun onVideoComplete() {
                                // 广告素材播放完成，例如视频未跳过，完整的播放了
                            }

                            override fun onVideoError() {
                                // 广告展示时出错
                            }

                            override fun onRewardVerify(
                                rewardVerify: Boolean,
                                rewardAmount: Int,
                                rewardName: String,
                                errorCode: Int,
                                errorMsg: String
                            ) {
                                // 已废弃 请使用 onRewardArrived 替代
                            }

                            override fun onRewardArrived(
                                isRewardValid: Boolean,
                                rewardType: Int,
                                extraInfo: Bundle
                            ) {
                                val result = NovRewardAdResult(isRewardValid)
                                callback.onRewardVerify(result)
                            }

                            override fun onSkippedVideo() {
                                // // 用户在观看时点击了跳过
                            }
                        })
                        showRewardVideoAd(activity)
                    }
                }

                override fun onRewardVideoCached() {}

                override fun onRewardVideoCached(p0: TTRewardVideoAd?) {}

            })
    }
}