import 'package:flutter/material.dart';
import 'package:keduo/pages/main/main_page.dart';
import '../pages/assistant/assistant_page.dart';
import '../pages/mine/mine_page.dart';
import 'baseColor.dart';
import 'baseSize.dart';

/*
SVG的使用
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.asset(
                      'assets/images/text_transform.svg',
                      //color: Colors.red,
                    ),

*/
class TabbarController extends StatefulWidget {
  TabbarController({Key key}) : super(key: key);

  @override
  _TabbarController createState() => _TabbarController();
}

class _TabbarController extends State<TabbarController> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = [MainPage()];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    if (_widgetOptions.length == 1) {
      _widgetOptions = [
        MainPage(),
        AssistantPage(),
        MinePage(),
      ];
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    BaseSize.getInstance().init(context);
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: SizedOverflowBox(
        alignment: Alignment.bottomCenter,
        size: Size(BaseSize.screenWidthPx, 49),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavigationBar(
                iconSize: 24,
                selectedFontSize: 12.0,
                type: BottomNavigationBarType.fixed, //不设置的话，item>3个会出现底部颜色不对
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Image(
                        image: AssetImage('assets/images/icons/ic_home.png'),
                        height: 28,
                      ),
                      title: Text('工作台'),
                      activeIcon: Image(
                          image: AssetImage(
                              'assets/images/icons/ic_home_select.png'),
                          height: 28)),
                  BottomNavigationBarItem(
                    icon: Image(
                        image: AssetImage('assets/images/icons/ic_search.png'),
                        height: 28),
                    title: Text(' '),
                  ),
                  BottomNavigationBarItem(
                    icon: Image(
                        image: AssetImage('assets/images/icons/ic_mine.png'),
                        height: 28),
                    title: Text('我的'),
                    activeIcon: Image(
                        image: AssetImage(
                            'assets/images/icons/ic_mine_select.png'),
                        height: 28),
                  ),
                ],
                backgroundColor: Colors.white,
                currentIndex: _selectedIndex,
                selectedItemColor: BaseColor.colorFF03B798,
                unselectedItemColor: Color(0xFF666666),
                onTap: _onItemTapped,
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  radius: 0.0, //取消点击的水波纹效果 这两句
                  child: new Image.asset(
                    'assets/images/icons/ic_search.png',
                    height: 80,
                  ),
                  onTap: onBigImgTap,
                )),
          ],
        ),
      ),
    );
  }

  onBigImgTap() {
    print("点击扫描按钮");
  }
  //Image(image: AssetImage('assets/images/icons/ic_mine_select.png'),height: 28)
}
