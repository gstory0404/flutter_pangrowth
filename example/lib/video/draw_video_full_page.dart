import 'package:flutter/material.dart';
import 'package:flutter_pangrowth/flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/14 12:14 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 


class DrawVideoFullPage extends StatefulWidget {
  const DrawVideoFullPage({Key? key}) : super(key: key);

  @override
  _DrawVideoFullPageState createState() => _DrawVideoFullPageState();
}

class _DrawVideoFullPageState extends State<DrawVideoFullPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("小说入口控件"),
      // ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("金刚位"),
              PangrowthVideo.drawVideoFullView(viewWidth: 400, viewHeight: 800),
            ],
          ),
        ),
      ),
    );
  }
}

