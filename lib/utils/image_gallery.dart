import 'package:flutter/material.dart';
import '../widget/my_app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/size_config.dart';

class ImageGallery {

  static Future<void> show(BuildContext context, List<String> images, int position) {

    PageController pageController = PageController(
      initialPage: position,
    );

    int _index = position;

    return showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.white,
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {

          return WillPopScope(
            onWillPop: () {

              Navigator.of(buildContext).pop();
              return Future(() => false);
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: StatefulBuilder(
                builder: (context, setState) {

                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Theme.of(context).backgroundColor,
                    child: Column(
                      children: [

                        MyAppBar("",
                          enableButtons: false,
                          onBackPress: () {

                            Navigator.of(buildContext).pop();
                          },
                        ),

                        Expanded(
                          child: Column(
                            children: [

                              Expanded(
                                flex: 6,
                                child: PhotoViewGallery.builder(
                                  backgroundDecoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  scrollPhysics: BouncingScrollPhysics(),
                                  pageController: pageController,
                                  itemCount: images.length,
                                  builder: (BuildContext context, int index) {

                                    return PhotoViewGalleryPageOptions(
                                      imageProvider: CachedNetworkImageProvider(images[index]),
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
                                      _index = page;
                                    });
                                  },
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: List.generate(images == null ? 0 : images.length, (index) =>

                                            Padding(
                                              padding: EdgeInsets.only(right: index < images.length - 1 ? 3.5 * SizeConfig.widthSizeMultiplier : 0),
                                              child: GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {

                                                  setState(() {
                                                    _index = index;
                                                  });

                                                  pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                                                },
                                                child: Container(
                                                  height: 8.125 * SizeConfig.heightSizeMultiplier,
                                                  width: 12.82 * SizeConfig.widthSizeMultiplier,
                                                  decoration: BoxDecoration(
                                                    color: index % 2 == 1 ? Theme.of(context).primaryColor.withOpacity(.1) : Colors.white,
                                                    borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
                                                    border: Border.all(width: _index == index ? 2.5 : 0, color: _index == index ? Theme.of(context).primaryColor : Colors.transparent),
                                                    image: DecorationImage(
                                                      image: CachedNetworkImageProvider(images[index] ?? ""),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
    );
  }
}