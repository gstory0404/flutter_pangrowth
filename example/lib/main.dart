import 'package:flutter/material.dart';
import 'package:flutter_pangrowth_example/novel/novel_page.dart';
import 'package:flutter_pangrowth_example/playlet/playlet_page.dart';

import 'video/video_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('穿山甲内容输出插件'),
      ),
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //小说
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child:  Text('小说'),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return const NovelPage();
                    },
                  ),
                );
              },
            ),
            //视频
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child:  const Text('视频'),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return const VideoPage();
                    },
                  ),
                );
              },
            ),
            //短剧
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child:  const Text('短剧'),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return const PlayletPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


}
