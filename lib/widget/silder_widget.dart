import 'package:extended_image/extended_image.dart';
import '../utils/slug_debugger.dart';

import '../utils/size_config.dart';
import 'package:flutter/material.dart';
import '../model/slider.dart' as my_model;
import 'package:carousel_slider/carousel_slider.dart';

class SliderWidget extends StatefulWidget {

  final List<my_model.Slider> sliders;

  SliderWidget(this.sliders);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[

        Container(
          width: double.infinity,
          height: 20 * SizeConfig.heightSizeMultiplier,
          child: CarouselSlider(
            items: widget.sliders.map((slider) {

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  SlugDebugger.debug(context, "", slider.slug);
                },
                child: Image.network(slider.image ?? "",
                  width: double.infinity,
                  height: double.infinity,
                  cacheHeight: 800,
                  cacheWidth: 800,
                  scale: .5,
                  fit: BoxFit.fill,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              aspectRatio: 16/9,
              enableInfiniteScroll: false,
              scrollDirection: Axis.horizontal,
              autoPlayInterval: Duration(milliseconds: 5500),
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {

                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),

        Container(
          width: double.infinity,
          height: 6.25 * SizeConfig.heightSizeMultiplier,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: _indicator(),
        ),
      ],
    );
  }


  Row _indicator() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.sliders.asMap().entries.map((entry) {

        return Container(
          width: (_currentIndex == entry.key ? 3.2 : 2) * SizeConfig.widthSizeMultiplier,
          height: 1.25 * SizeConfig.heightSizeMultiplier,
          margin: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightSizeMultiplier,
            horizontal: 1.5 * SizeConfig.widthSizeMultiplier,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(_currentIndex == entry.key ? 1 : 0.25),
          ),
        );
      }).toList(),
    );
  }
}