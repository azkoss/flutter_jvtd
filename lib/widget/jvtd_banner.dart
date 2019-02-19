import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../widget/jvtd_image.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class JvtdBanner extends StatelessWidget {
  final SwiperOnTap onTap;
  final List<String> bannerImages;
  final bool autoPlay;
  final int autoPlayDely;
  final bool loop;
  final String placeholder;
  final Color indicatorBgColor;
  final Color indicatorColor;
  final Color indicatorActiveColor;
  final double indicatorSize;
  final double space;
  final double indicatorHeight;
  final Alignment indicatorAlignment;
  final EdgeInsets indicatorPadding;

  const JvtdBanner({
    Key key,
    this.onTap,
    this.bannerImages,
    this.autoPlay = true,
    this.autoPlayDely = 5000,
    this.loop = true,
    this.placeholder,
    this.indicatorBgColor = Colors.black12,
    this.indicatorColor = Colors.blue,
    this.indicatorActiveColor = Colors.white,
    this.indicatorSize = 10,
    this.space = 3,
    this.indicatorHeight = 30,
    this.indicatorAlignment = Alignment.center,
    this.indicatorPadding = const EdgeInsets.all(0),
  }) : super(key: key);

  Widget _buildItem(BuildContext context, int index) {
    return JvtdImage.network(
      url: bannerImages[index],
      placeholderImgName: placeholder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return bannerImages == null || bannerImages.length <= 0
        ? ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: JvtdImage.local(name: placeholder),
          )
        : Swiper(
            itemCount: bannerImages.length,
            onTap: onTap,
            loop: loop,
            autoplay: autoPlay,
            autoplayDelay: autoPlayDely,
            itemBuilder: _buildItem,
            pagination: new SwiperPagination(
              margin: new EdgeInsets.all(0.0),
              alignment: Alignment.bottomCenter,
              builder: SwiperCustomPagination(
                builder: (BuildContext context, SwiperPluginConfig config) {
                  return new ConstrainedBox(
                    child: new Container(
                      alignment: indicatorAlignment,
                      color: indicatorBgColor,
                      padding: indicatorPadding,
                      child: PageIndicator(
                        count: config.itemCount,
                        controller: config.pageController,
                        layout: PageIndicatorLayout.SCALE,
                        size: indicatorSize,
                        activeColor: indicatorActiveColor,
                        color: indicatorColor,
                        space: space,
                      ),
                    ),
                    constraints: new BoxConstraints.expand(height: indicatorHeight),
                  );
                },
              ),
            ),
          );
  }
}
