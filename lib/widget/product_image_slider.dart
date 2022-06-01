import 'package:extended_image/extended_image.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../utils/size_config.dart';
import '../utils/api_routes.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductImageSlider extends StatefulWidget {

  final List<String> images;

  ProductImageSlider(this.images);

  @override
  _ProductImageSliderState createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {

  int _currentIndex = 0;

  CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[

        Container(
          child: CarouselSlider(
            items: widget.images.map((imageUrl) {

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  _showFullImage();
                },
                child: Container(
                  child: Image.network(imageUrl ?? (APIRoute.BASE_URL + ""),
                    cacheHeight: 500,
                    cacheWidth: 500,
                    fit: BoxFit.fill,
                    scale: .5,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              initialPage: 0,
              height: double.infinity,
              enlargeCenterPage: false,
              autoPlay: false,
              reverse: false,
              enableInfiniteScroll: false,
              scrollDirection: Axis.horizontal,
              autoPlayCurve: Curves.fastOutSlowIn,
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
      children: widget.images.asMap().entries.map((entry) {

        return Container(
          width: 2.56 * SizeConfig.widthSizeMultiplier,
          height: 1.25 * SizeConfig.heightSizeMultiplier,
          margin: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightSizeMultiplier,
            horizontal: 1.02 * SizeConfig.widthSizeMultiplier,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor.withOpacity(_currentIndex == entry.key ? 1 : 0.2),
          ),
        );
      }).toList(),
    );
  }


  Future<void> _showFullImage() {

    PageController pageController = PageController(
      initialPage: _currentIndex,
    );

    return showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black45,
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {

          return WillPopScope(
            onWillPop: () {

              Navigator.of(buildContext).pop();
              return Future(() => false);
            },
            child: StatefulBuilder(
              builder: (context, setState) {

                return Stack(
                  children: <Widget>[

                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Theme.of(context).backgroundColor,
                      child: PhotoViewGallery.builder(
                        scrollPhysics: BouncingScrollPhysics(),
                        pageController: pageController,
                        itemCount: widget.images.length,
                        builder: (BuildContext context, int index) {

                          return PhotoViewGalleryPageOptions(
                            imageProvider: ExtendedNetworkImageProvider(widget.images[index]),
                            initialScale: PhotoViewComputedScale.contained * 1,
                            minScale: PhotoViewComputedScale.contained * 1,
                            maxScale: PhotoViewComputedScale.contained * 10,
                          );
                        },
                        loadingBuilder: (context, event) => Center(
                          child: Container(
                            height: 2.25 * SizeConfig.heightSizeMultiplier,
                            width: 5.12 * SizeConfig.widthSizeMultiplier,
                            child: CircularProgressIndicator(
                              value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                            ),
                          ),
                        ),
                        onPageChanged: (page) {

                          setState(() {
                            _currentIndex = page;
                          });
                        },
                      ),
                    ),

                    Positioned(
                      left: 7.69 * SizeConfig.widthSizeMultiplier,
                      top: 6.25 * SizeConfig.heightSizeMultiplier,
                      child: GestureDetector(
                        onTap: () {

                          Navigator.of(buildContext).pop();
                        },
                        child: Icon(Ionicons.close_circle, size: 7.69 * SizeConfig.imageSizeMultiplier, color: Colors.white,),
                      ),
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 5.12 * SizeConfig.widthSizeMultiplier,
                          right: 5.12 * SizeConfig.widthSizeMultiplier,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            Visibility(
                              visible: _currentIndex > 0,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {

                                  try {

                                    if(_currentIndex > 0) {

                                      setState(() {
                                        _currentIndex = _currentIndex - 1;
                                      });

                                      _carouselController.previousPage();
                                      pageController.previousPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                                    }
                                  }
                                  catch(error) {}
                                },
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  radius: 2.25 * SizeConfig.heightSizeMultiplier,
                                  child: Icon(Icons.arrow_back_ios, size: 4.5 * SizeConfig.imageSizeMultiplier, color: Colors.white,),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: _currentIndex < (widget.images.length - 1),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {

                                  try {

                                    if(_currentIndex < (widget.images.length - 1)) {

                                      setState(() {
                                        _currentIndex = _currentIndex + 1;
                                      });

                                      _carouselController.nextPage();
                                      pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                                    }
                                  }
                                  catch(error) {}
                                },
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  radius: 2.25 * SizeConfig.heightSizeMultiplier,
                                  child: Icon(Icons.arrow_forward_ios, size: 4.5 * SizeConfig.imageSizeMultiplier, color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
    );
  }
}