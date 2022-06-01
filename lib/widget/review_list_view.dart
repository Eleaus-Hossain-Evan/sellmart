import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../localization/app_localization.dart';
import '../model/review.dart';
import '../utils/size_config.dart';
import '../utils/my_datetime.dart';
import '../utils/image_gallery.dart';

class ReviewListView extends StatefulWidget {

  final BuildContext parentContext;
  final int limit;
  final List<Review> reviews;

  ReviewListView(this.reviews, this.parentContext, {this.limit});

  @override
  _ReviewListViewState createState() => _ReviewListViewState();
}

class _ReviewListViewState extends State<ReviewListView> {

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.limit,
      separatorBuilder: (BuildContext context, int index) {

        return Container(
          height: .1625 * SizeConfig.heightSizeMultiplier,
          color: Colors.black12,
          margin: EdgeInsets.only(
            top: 1.875 * SizeConfig.heightSizeMultiplier,
            bottom: 1.875 * SizeConfig.heightSizeMultiplier,
          ),
        );
      },
      itemBuilder: (BuildContext context, int index) {

        return Visibility(
          visible: widget.reviews[index].approved,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text(widget.reviews[index].userName ?? (widget.reviews[index].userPhone ?? ""),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 1.625 * SizeConfig.textSizeMultiplier,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(.6),
                ),
              ),

              SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),

              Row(
                children: <Widget>[

                  Row(
                    children: List.generate(5, (starIndex) {

                      return Icon(Icons.star,
                        size: 4 * SizeConfig.imageSizeMultiplier,
                        color: starIndex < widget.reviews[index].rating ? Colors.yellow[600] : Colors.grey,
                      );
                    }),
                  ),

                  SizedBox(width: 1.28 * SizeConfig.widthSizeMultiplier,),

                  Text(".",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 5 * SizeConfig.textSizeMultiplier,
                      height: .05 * SizeConfig.heightSizeMultiplier,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[300],
                    ),
                  ),

                  SizedBox(width: 1.28 * SizeConfig.widthSizeMultiplier,),

                  Text(AppLocalization.of(context).getTranslatedValue("posted_on") + MyDateTime.getReviewDate(DateTime.parse(widget.reviews[index].date ?? "")),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                      height: .20625 * SizeConfig.heightSizeMultiplier,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

              Text(widget.reviews[index].comment ?? "",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

              Visibility(
                visible: widget.reviews[index].images != null && widget.reviews[index].images.length > 0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(widget.reviews[index].images == null ? 0 : widget.reviews[index].images.length, (imageIndex) =>

                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {

                            ImageGallery.show(widget.parentContext, widget.reviews[index].images, imageIndex);
                          },
                          child: Container(
                            height: 5.625 * SizeConfig.heightSizeMultiplier,
                            width: 11.53 * SizeConfig.widthSizeMultiplier,
                            margin: EdgeInsets.only(right: 2.56 * SizeConfig.widthSizeMultiplier),
                            decoration: BoxDecoration(
                              color: Theme.of(context).hintColor,
                              borderRadius: BorderRadius.circular(1 * SizeConfig.heightSizeMultiplier),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(widget.reviews[index].images[imageIndex]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}