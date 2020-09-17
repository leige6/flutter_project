import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:keduo/model/mainModel.dart';

class AdView extends StatefulWidget {
  final List<BannerLists> imgList;
  const AdView({this.imgList, Key key}) : super(key: key);

  @override
  AdViewState createState() => AdViewState();
}

class AdViewState extends State<AdView> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      child: widget.imgList.length != 0
          ? Swiper(
              itemBuilder: _swiperBuilder,
              itemCount: widget.imgList.length,
              pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                color: Colors.red,
                activeColor: Colors.white,
              )),
              control: new SwiperControl(iconNext: null, iconPrevious: null),
              scrollDirection: Axis.horizontal,
              autoplay: true,
              onTap: (index) => print('点击了第$index个'),
            )
          : Container(),
      constraints: new BoxConstraints.loose(new Size(
          MediaQuery.of(context).size.width,
          widget.imgList.length != 0 ? 155.0 : 30)),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      widget.imgList[index].bannerImg,
      fit: BoxFit.fill,
    ));
  }
}
