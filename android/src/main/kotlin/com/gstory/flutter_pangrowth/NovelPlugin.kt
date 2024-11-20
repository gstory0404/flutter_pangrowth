package com.gstory.flutter_pangrowth

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import com.alibaba.fastjson.JSON
import com.alibaba.fastjson.JSONObject
import com.bytedance.sdk.djx.interfaces.listener.IDJXAdListener
import com.bytedance.sdk.djx.model.DJXError
import com.bytedance.sdk.djx.model.DJXOthers
import com.bytedance.sdk.nov.api.INovCallback
import com.bytedance.sdk.nov.api.NovSdkConfig
import com.bytedance.sdk.nov.api.NovSdk
import com.bytedance.sdk.nov.api.model.NovCategory
import com.bytedance.sdk.nov.api.model.NovStory
import com.bytedance.sdk.nov.api.params.NovReaderConfig
import com.bytedance.sdk.nov.api.params.NovWidgetReaderParams
import com.gstory.flutter_pangrowth.novel.pages.NovelAggregatePageActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * @Author: gstory
 * @CreateDate: 2021/12/13 3:13 下午
 * @Description: 描述
 */

object NovelPlugin {

    /**
     * 小说注册
     */
    fun registerNovel(context: Context?, call: MethodCall, result: MethodChannel.Result) {
        val debug = call.argument<Boolean>("debug") as Boolean
        val config = NovSdkConfig.Builder().debug(debug).build()
        NovSdk.init(context!!, "pangrowthconfig.json", config)
        NovSdk.start(object : NovSdk.StartListener {
            override fun onStartComplete(isSuccess: Boolean, message: String?, error: DJXError?) {
                result.success(isSuccess)
            }
        })
    }

    /**
     * 打开小说聚合页
     */
    fun openNovelAggregatePage(activity: Activity?, call: MethodCall, result: MethodChannel.Result) {
        activity?.startActivity(Intent(activity, NovelAggregatePageActivity::class.java))
    }

    /**
     * 打开小说主页
     */
    fun openMiniStory(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val novelId = params["novelId"] as Int
        val index = params["index"] as Int
        NovSdk.service()
            ?.requestStoryByIds(listOf(novelId), index, 20, object : INovCallback<List<NovStory>> {
                override fun onError(error: DJXError) {
                    result.success(false)
                }

                override fun onSuccess(data: List<NovStory>, others: DJXOthers?) {
                    //阅读器配置 NovReaderConfig
                    val config = NovReaderConfig().apply {
                        //广告模式 可以选自SDK直出广告 or 自定义广告
                        rewardAdMode = NovReaderConfig.NovRewardAdMode.MODE_SDK
                        //文末推荐卡片样式
                        endPageCardStyle = NovReaderConfig.NovEndPageCardStyle.STYLE_MIX
                    }
                    //打开短故事阅读器
                    NovSdk.factory()?.openReader(NovWidgetReaderParams(data.first(), config))
                    result.success(true)
                }
            })
    }

    /**
     * 查询小说类目
     */
    fun requestNovelCategoryList(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        NovSdk.service()?.requestCategoryList(object : INovCallback<List<NovCategory>> {
            override fun onError(error: DJXError) {
                result.success(null)
            }

            override fun onSuccess(data: List<NovCategory>, others: DJXOthers?) {
                result.success(JSON.toJSON(data))
            }
        })
    }

    /**
     * 根据搜索关键词获取短剧列表
     */
    fun requestStoryListWithSearchWord(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val keyword = params["keyword"] as String
        val isFuzzy = params["isFuzzy"] as Boolean
        val page = params["page"] as Int
        val size = params["size"] as Int
        NovSdk.service()
            ?.searchStory(keyword, isFuzzy, page, size, object : INovCallback<List<NovStory>> {
                override fun onError(error: DJXError) {
                    result.success(null)
                }

                override fun onSuccess(data: List<NovStory>, others: DJXOthers?) {
                    val list2 = ArrayList<String>()
                    for (novel: NovStory in data) {
                        list2.add(JSON.toJSON(novel).toString())
                    }
                    result.success(list2)
                }
            })
    }

    /**
     * 短故事按照book_id查询
     */
    fun requestStoryListWithBookId(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val ids = (params["ids"] as List<String>).map { it.toInt() }.toTypedArray().toList()
        NovSdk.service()
            ?.requestStoryByIds(ids, 1, 100, object : INovCallback<List<NovStory>> {
                override fun onError(error: DJXError) {
                    result.success(null)
                }

                override fun onSuccess(data: List<NovStory>, others: DJXOthers?) {
                    val list2 = ArrayList<String>()
                    for (novel: NovStory in data) {
                        list2.add(JSON.toJSON(novel).toString())
                    }
                    result.success(list2)
                }
            })
    }


    /**
     * 短故事分页加载
     */
    fun requestAllStoryListPage(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val page = params["page"] as Int
        val size = params["size"] as Int
        val order = params["order"] as Int
        NovSdk.service()
            ?.requestStoryFeed(order, page, size, object : INovCallback<List<NovStory>> {
                override fun onError(error: DJXError) {
                    result.success(null)
                }

                override fun onSuccess(data: List<NovStory>, others: DJXOthers?) {
                    val list2 = ArrayList<String>()
                    for (novel: NovStory in data) {
                        list2.add(JSON.toJSON(novel).toString())
                    }
                    result.success(list2)
                }
            })
    }

    /**
     * 短故事分页加载
     */
    fun requestCategoryStoryListWithCategoryId(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val categoryId = params["categoryId"] as Int
        val page = params["page"] as Int
        val size = params["size"] as Int
        val order = params["order"] as Int
        NovSdk.service()
            ?.requestStoryByCategory(categoryId,order, page, size, object : INovCallback<List<NovStory>> {
                override fun onError(error: DJXError) {
                    result.success(null)
                }

                override fun onSuccess(data: List<NovStory>, others: DJXOthers?) {
                    val list2 = ArrayList<String>()
                    for (novel: NovStory in data) {
                        list2.add(JSON.toJSON(novel).toString())
                    }
                    result.success(list2)
                }
            })
    }

    /**
     * 短故事分页加载
     */
    fun requestHistoryStoryList(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val page = params["page"] as Int
        val size = params["size"] as Int
        NovSdk.service()
            ?.getStoryHistory(page, size, object : INovCallback<List<NovStory>> {
                override fun onError(error: DJXError) {
                    result.success(null)
                }

                override fun onSuccess(data: List<NovStory>, others: DJXOthers?) {
                    val list2 = ArrayList<String>()
                    for (novel: NovStory in data) {
                        list2.add(JSON.toJSON(novel).toString())
                    }
                    result.success(list2)
                }
            })
    }

    /**
     * 短故事收藏
     */
    fun requestCollectStory(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val novelId = params["novelId"] as Int
        NovSdk.service()
            ?.storyFavorite(novelId, object : INovCallback<Boolean> {
                override fun onError(error: DJXError) {
                    result.success(null)
                }

                override fun onSuccess(data: Boolean, others: DJXOthers?) {
                    result.success(data)
                }
            })
    }

    /**
     * 短故事取消收藏
     */
    fun requestCancelCollectStory(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val novelId = params["novelId"] as Int
        NovSdk.service()
            ?.storyFavoriteCancel(novelId, object : INovCallback<Boolean> {
                override fun onError(error: DJXError) {
                    result.success(null)
                }

                override fun onSuccess(data: Boolean, others: DJXOthers?) {
                    result.success(data)
                }
            })
    }

    /**
     * 获取短故事收藏列表
     */
    fun requestStoryCollectionList(
        activity: Activity?,
        result: MethodChannel.Result,
        params: Map<String?, Any?>
    ) {
        val page = params["page"] as Int
        val size = params["size"] as Int
        NovSdk.service()
            ?.getStoryFavorite(page, size, object : INovCallback<List<NovStory>> {
                override fun onError(error: DJXError) {
                    result.success(null)
                }

                override fun onSuccess(data: List<NovStory>, others: DJXOthers?) {
                    val list2 = ArrayList<String>()
                    for (novel: NovStory in data) {
                        list2.add(JSON.toJSON(novel).toString())
                    }
                    result.success(list2)
                }
            })
    }
}