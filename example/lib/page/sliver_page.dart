import 'package:example/generated/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// CustomScrollView示例页面
class SliverPage extends StatefulWidget {
  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {

  List<String> addStr=["1","2","3","4","5","6","7","8","9","0"];
  List<String> str=["1","2","3","4","5","6","7","8","9","0"];
  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new EasyRefresh(
        key: _easyRefreshKey,
        refreshHeader: ClassicsHeader(
          key: _headerKey,
          refreshText: Translations.of(context).text("pullToRefresh"),
          refreshReadyText: Translations.of(context).text("releaseToRefresh"),
          refreshingText: Translations.of(context).text("refreshing") + "...",
          refreshedText: Translations.of(context).text("refreshed"),
          moreInfo: Translations.of(context).text("updateAt"),
          bgColor: Colors.orange,
          textColor: Colors.black,
        ),
        refreshFooter: ClassicsFooter(
          key: _footerKey,
          loadHeight: 50.0,
          loadText: Translations.of(context).text("pushToLoad"),
          loadReadyText: Translations.of(context).text("releaseToLoad"),
          loadingText: Translations.of(context).text("loading"),
          loadedText: Translations.of(context).text("loaded"),
          noMoreText: Translations.of(context).text("noMore"),
          moreInfo: Translations.of(context).text("updateAt"),
          bgColor: Colors.orange,
          textColor: Colors.black,
        ),
        onRefresh: () async{
          await new Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              str.clear();
              str.addAll(addStr);
            });
          });
        },
        loadMore: () async {
          await new Future.delayed(const Duration(seconds: 1), () {
            if (str.length < 20) {
              setState(() {
                str.addAll(addStr);
              });
            }
          });
        },
        child: CustomScrollView(
          // 手动维护semanticChildCount,用于判断是否没有更多数据
          semanticChildCount: str.length,
          slivers: <Widget>[
            SliverAppBar(
              floating: false,
              pinned: true,
              expandedHeight: 180.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("CustomScrollView"),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(0.0),
              sliver: SliverFixedExtentList(
                itemExtent: 70.0,
                delegate: SliverChildBuilderDelegate((context, index){
                    return new Container(
                        height: 70.0,
                        child: Card(
                          child: new Center(
                            child: new Text(str[index],style: new TextStyle(fontSize: 18.0),),
                          ),
                        )
                    );
                  },
                  childCount: str.length,
                )
              ),
            )
          ],
        )
      )
    );
  }
}