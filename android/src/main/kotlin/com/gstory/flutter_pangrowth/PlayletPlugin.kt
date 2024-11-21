package com.gstory.flutter_pangrowth

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import com.alibaba.fastjson.JSON
import com.bytedance.sdk.djx.DJXSdk
import com.bytedance.sdk.djx.DJXSdkConfig
import com.bytedance.sdk.djx.IDJXService
import com.bytedance.sdk.djx.model.DJXDrama
import com.bytedance.sdk.djx.model.DJXError
import com.bytedance.sdk.djx.model.DJXOthers
import com.bytedance.sdk.nov.api.INovCallback
import com.bytedance.sdk.nov.api.NovSdk
import com.bytedance.sdk.nov.api.model.NovStory
import com.bytedance.sdk.nov.api.params.NovReaderConfig
import com.bytedance.sdk.nov.api.params.NovWidgetReaderParams
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.gstory.flutter_pangrowth.playlet.pages.PlayletAggregatePageActivity
import com.gstory.flutter_pangrowth.playlet.pages.PlayletPlayerPage

/**
 * @Author: gstory
 * @CreateDate: 2024/11/19 16:47
 * @Description: 短剧管理
 */

object PlayletPlugin {

    /**
     * 短剧注册
     */
    fun registerPlaylet(activity: Activity?, call: MethodCall, result: MethodChannel.Result) {
        val debug = call.argument<Boolean>("debug") as Boolean
        val config = DJXSdkConfig.Builder().debug(debug).build()
        DJXSdk.init(activity!!, "pangrowthconfig.json", config)
        DJXSdk.start(object : DJXSdk.StartListener {
            override fun onStartComplete(isSuccess: Boolean, message: String?, error: DJXError?) {
                Log.d("PlayletPlugin", "短剧初始化$isSuccess")
                result.success(isSuccess)
            }
        })
    }

    /**
     * 打开短剧聚合页
     */
    fun openPlayletAggregatePage(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val freeCount = params["freeCount"] as Int
        val unlockCount = params["unlockCount"] as Int
        val isShowTitle = params["isShowTitle"] as Boolean
        val isShowBackButton = params["isShowBackButton"] as Boolean
        val intent = Intent(activity, PlayletAggregatePageActivity::class.java)
        intent.putExtra("freeCount",freeCount)
        intent.putExtra("unlockCount",unlockCount)
        intent.putExtra("isShowTitle",isShowTitle)
        intent.putExtra("isShowBackButton",isShowBackButton)
        activity?.startActivity(intent)
    }

    //进入播放器
    fun enterPlayletPlayer(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val playletId = (params["playletId"] as Int) * 1L
        val index = params["index"] as Int
        val freeCount = params["freeCount"] as Int
        val unlockCount = params["unlockCount"] as Int
        val intent = Intent(activity, PlayletPlayerPage::class.java)
        intent.putExtra("playletId",playletId)
        intent.putExtra("index",index)
        intent.putExtra("freeCount",freeCount)
        intent.putExtra("unlockCount",unlockCount)
        activity?.startActivity(intent)
    }

    //分页加载所有短剧
    fun requestAllPlayletListPage(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val page = params["page"] as Int
        val size = params["size"] as Int
        val order = params["order"] as Int
        DJXSdk.service().requestAllDrama(page, size, order == 0, object :
            IDJXService.IDJXCallback<MutableList<out DJXDrama>?> {
            override fun onSuccess(dramas: MutableList<out DJXDrama>?, p1: DJXOthers?) {
                val list = ArrayList<String>()
                for (drama: DJXDrama in dramas!!) {
                    list.add(JSON.toJSON(drama).toString())
//                    Log.d("===>",JSON.toJSON(drama).toString())
                }
                result.success(list)
            }

            override fun onError(p0: DJXError) {
                result.success(null)
            }
        })
    }

    //分页加载推荐短剧
    fun requestRecommendedPlayletListPage(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val page = params["page"] as Int
        val size = params["size"] as Int
        DJXSdk.service().requestAllDramaByRecommend(page, size, object :
            IDJXService.IDJXCallback<MutableList<out DJXDrama>?> {
            override fun onSuccess(dramas: MutableList<out DJXDrama>?, p1: DJXOthers?) {
                val list = ArrayList<String>()
                for (drama: DJXDrama in dramas!!) {
                    list.add(JSON.toJSON(drama).toString())
//                    Log.d("===>",JSON.toJSON(drama).toString())
                }
                result.success(list)
            }

            override fun onError(p0: DJXError) {
                result.success(null)
            }
        })
    }


    // 根据短剧id获取短剧信息
    fun requestPlayletListWithPlayletId(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val ids = (params["ids"] as List<String>).map { it.toLong() }.toTypedArray().toList()
        DJXSdk.service().requestDrama(ids, object :
            IDJXService.IDJXCallback<MutableList<out DJXDrama>?> {
            override fun onSuccess(dramas: MutableList<out DJXDrama>?, p1: DJXOthers?) {
                val list = ArrayList<String>()
                for (drama: DJXDrama in dramas!!) {
                    list.add(JSON.toJSON(drama).toString())
//                    Log.d("===>",JSON.toJSON(drama).toString())
                }
                result.success(list)
            }

            override fun onError(p0: DJXError) {
                result.success(null)
            }
        })
    }

    // 根据搜索关键词获取短剧列表
    fun requestCategoryPlayletLisWithSearchWord(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val keyword = params["keyword"] as String
        val isFuzzy = params["isFuzzy"] as Boolean
        val page = params["page"] as Int
        val size = params["size"] as Int
        DJXSdk.service().searchDrama(keyword, isFuzzy, page, size, object :
            IDJXService.IDJXCallback<MutableList<out DJXDrama>?> {
            override fun onSuccess(dramas: MutableList<out DJXDrama>?, p1: DJXOthers?) {
                val list = ArrayList<String>()
                for (drama: DJXDrama in dramas!!) {
                    list.add(JSON.toJSON(drama).toString())
//                    Log.d("===>",JSON.toJSON(drama).toString())
                }
                result.success(list)
            }

            override fun onError(p0: DJXError) {
                result.success(null)
            }
        })
    }

    // 获取分类列表
    fun requestPlayletCategoryList(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        DJXSdk.service().requestDramaCategoryList(object :
            IDJXService.IDJXCallback<MutableList<String>?> {
            override fun onSuccess(datas: MutableList<String>?, p1: DJXOthers?) {
                val list = ArrayList<String>()
                for (drama: String in datas!!) {
                    list.add(JSON.toJSON(drama).toString())
//                    Log.d("===>",JSON.toJSON(drama).toString())
                }
                result.success(list)
            }

            override fun onError(p0: DJXError) {
                result.success(null)
            }
        })
    }

 // 根据分类获取列表
    fun requestCategoryPlayletLisWithCategory(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val category = params["category"] as String
        val page = params["page"] as Int
        val size = params["size"] as Int
        DJXSdk.service().requestDramaByCategory(category, page, size,0, object :
            IDJXService.IDJXCallback<MutableList<out DJXDrama>?> {
            override fun onSuccess(dramas: MutableList<out DJXDrama>?, p1: DJXOthers?) {
                val list = ArrayList<String>()
                for (drama: DJXDrama in dramas!!) {
                    list.add(JSON.toJSON(drama).toString())
//                    Log.d("===>",JSON.toJSON(drama).toString())
                }
                result.success(list)
            }

            override fun onError(p0: DJXError) {
                result.success(null)
            }
        })
    }

    // 播放记录
    fun requestPlayletHistoryListWithPage(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val page = params["page"] as Int
        val size = params["size"] as Int
        DJXSdk.service().getDramaHistory(page, size, object :
            IDJXService.IDJXCallback<MutableList<out DJXDrama>?> {
            override fun onSuccess(dramas: MutableList<out DJXDrama>?, p1: DJXOthers?) {
                val list = ArrayList<String>()
                for (drama: DJXDrama in dramas!!) {
                    list.add(JSON.toJSON(drama).toString())
//                    Log.d("===>",JSON.toJSON(drama).toString())
                }
                result.success(list)
            }

            override fun onError(p0: DJXError) {
                result.success(null)
            }
        })
    }

    // 清理播放记录
    fun requestPlayletHistoryClean(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        DJXSdk.service().clearDramaHistory(object :
            IDJXService.IDJXCallback<MutableList<out DJXDrama>?> {
            override fun onSuccess(dramas: MutableList<out DJXDrama>?, p1: DJXOthers?) {
                result.success(true)
            }

            override fun onError(p0: DJXError) {
                result.success(false)
            }
        })
    }

    // 点赞
    fun likeShortplay(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>,
        isLike: Boolean
    ) {
        val playletId = (params["playletId"] as Int).toLong()
        val index = params["index"] as Int
        DJXSdk.service().likeEpisode(playletId,index,isLike,object :
            IDJXService.IDJXCallback<Any?> {
            override fun onSuccess(p0: Any?, p1: DJXOthers?) {
                result.success(true)
            }


            override fun onError(p0: DJXError) {
                result.success(false)
            }
        })
    }

    // 收藏
    fun collectShortplay(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>,
        isCollect: Boolean
    ) {
        val playletId = (params["playletId"] as Int).toLong()
        DJXSdk.service().favorDrama(playletId,isCollect,object :
            IDJXService.IDJXCallback<Any?> {
            override fun onSuccess(p0: Any?, p1: DJXOthers?) {
                result.success(true)
            }


            override fun onError(p0: DJXError) {
                result.success(false)
            }
        })
    }


    // 收藏列表
    fun requestCollectionList(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val page = params["page"] as Int
        val size = params["size"] as Int
        DJXSdk.service().getFavorList(page, size, object :
            IDJXService.IDJXCallback<MutableList<out DJXDrama>?> {
            override fun onSuccess(dramas: MutableList<out DJXDrama>?, p1: DJXOthers?) {
                val list = ArrayList<String>()
                for (drama: DJXDrama in dramas!!) {
                    list.add(JSON.toJSON(drama).toString())
//                    Log.d("===>",JSON.toJSON(drama).toString())
                }
                result.success(list)
            }

            override fun onError(p0: DJXError) {
                result.success(null)
            }
        })
    }
}