import 'dart:convert';
import 'dart:io';

import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import '../utils/my_flush_bar.dart';
import '../contract/connectivity_contract.dart';
import '../contract/review_contract.dart';
import '../localization/app_localization.dart';
import '../model/product.dart';
import '../model/review.dart';
import '../presenter/data_presenter.dart';
import '../utils/image_compressor.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widget/bottom_aligned_button.dart';

class WriteReview extends StatefulWidget {
  final Product product;

  WriteReview(this.product);

  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview>
    implements Connectivity, ReviewContract {
  DataPresenter _presenter;

  Connectivity _connectivity;
  ReviewContract _reviewContract;

  Review _review = Review(rating: 0, images: [], base64Images: [], comment: "");

  @override
  void initState() {
    _connectivity = this;
    _reviewContract = this;

    _presenter = DataPresenter(_connectivity, reviewContract: _reviewContract);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return SafeArea(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 8.5 * SizeConfig.heightSizeMultiplier,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 8.5 * SizeConfig.heightSizeMultiplier),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overScroll) {
                          overScroll.disallowGlow();
                          return;
                        },
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(
                                1.875 * SizeConfig.heightSizeMultiplier),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _productWidget(),
                                SizedBox(
                                  height:
                                      4.375 * SizeConfig.heightSizeMultiplier,
                                ),
                                Material(
                                  elevation: 2,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      .625 * SizeConfig.heightSizeMultiplier),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(.625 *
                                          SizeConfig.heightSizeMultiplier),
                                    ),
                                    padding: EdgeInsets.all(
                                        1 * SizeConfig.heightSizeMultiplier),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: List.generate(5, (index) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            setState(() {
                                              _review.rating = index + 1;
                                            });
                                          },
                                          child: Icon(
                                            index < _review.rating
                                                ? Icons.star
                                                : Icons.star_border,
                                            size: 9 *
                                                SizeConfig.imageSizeMultiplier,
                                            color: index < _review.rating
                                                ? Colors.yellow[600]
                                                : Colors.grey[500],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      4.375 * SizeConfig.heightSizeMultiplier,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 1.28 *
                                          SizeConfig.widthSizeMultiplier),
                                  child: Text(
                                    AppLocalization.of(context)
                                        .getTranslatedValue(
                                            "how_was_the_product"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[800],
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      1.875 * SizeConfig.heightSizeMultiplier,
                                ),
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.done,
                                  maxLines: null,
                                  minLines: 8,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(fontWeight: FontWeight.normal),
                                  onChanged: (value) {
                                    _review.comment = value;
                                  },
                                  onSubmitted: (string) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: AppLocalization.of(context)
                                        .getTranslatedValue("write_comment"),
                                    hintStyle: TextStyle(
                                      fontSize:
                                          2.2 * SizeConfig.textSizeMultiplier,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54,
                                          width: .102 *
                                              SizeConfig.widthSizeMultiplier),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54,
                                          width: .102 *
                                              SizeConfig.widthSizeMultiplier),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54,
                                          width: .102 *
                                              SizeConfig.widthSizeMultiplier),
                                    ),
                                    contentPadding: EdgeInsets.all(
                                        1.65 * SizeConfig.heightSizeMultiplier),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      4.375 * SizeConfig.heightSizeMultiplier,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 1.28 *
                                          SizeConfig.widthSizeMultiplier),
                                  child: Text(
                                    AppLocalization.of(context)
                                        .getTranslatedValue("add_images"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[800],
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      1.875 * SizeConfig.heightSizeMultiplier,
                                ),
                                _review.images.length > 0
                                    ? _pickedImages()
                                    : _clickToUploadWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  MyAppBar(
                    AppLocalization.of(context)
                        .getTranslatedValue("write_review"),
                    onBackPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),
                  BottomAlignedButton(
                    AppLocalization.of(context).getTranslatedValue("submit"),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      _validate(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPress() {
    Navigator.pop(context);
    return Future(() => false);
  }

  @override
  void dispose() {
    _presenter.hideOverlayLoader();
    super.dispose();
  }

  Widget _productWidget() {
    return Material(
      elevation: 3,
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
      child: Container(
        padding: EdgeInsets.all(1.28 * SizeConfig.heightSizeMultiplier),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  height: 10 * SizeConfig.heightSizeMultiplier,
                  margin:
                      EdgeInsets.all(.3125 * SizeConfig.heightSizeMultiplier),
                  color: Colors.white,
                  child: Image.network(
                    widget.product.thumbnail ?? "",
                    fit: BoxFit.fill,
                    errorBuilder: (context, url, error) => Icon(
                      Icons.image,
                      size: 10.5 * SizeConfig.heightSizeMultiplier,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 2.56 * SizeConfig.widthSizeMultiplier,
                    right: 2.56 * SizeConfig.widthSizeMultiplier,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        widget.product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 1.8 * SizeConfig.textSizeMultiplier,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: 1.875 * SizeConfig.heightSizeMultiplier,
                      ),
                      Text(
                        (widget.product.salePrice.truncate() *
                                widget.product.quantity)
                            .round()
                            .toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.black,
                              fontSize: 1.8 * SizeConfig.textSizeMultiplier,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        widget.product.salePrice.round().toString() +
                            " x " +
                            widget.product.quantity.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.black54,
                              fontSize: 1.8 * SizeConfig.textSizeMultiplier,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _clickToUploadWidget() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        selectImages();
      },
      child: Material(
        elevation: 2,
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
        child: Container(
          padding: EdgeInsets.only(
            top: 5 * SizeConfig.heightSizeMultiplier,
            bottom: 5 * SizeConfig.heightSizeMultiplier,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.cloud_upload,
                  size: 35,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 1.25 * SizeConfig.heightSizeMultiplier,
                ),
                Text(
                  AppLocalization.of(context)
                      .getTranslatedValue("click_here_to_upload"),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pickedImages() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _review.images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 1.25 * SizeConfig.heightSizeMultiplier,
        crossAxisSpacing: 2.56 * SizeConfig.widthSizeMultiplier,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Image.file(
              File(_review.images[index]),
              height: 25 * SizeConfig.heightSizeMultiplier,
              width: 51.28 * SizeConfig.widthSizeMultiplier,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: .25 * SizeConfig.heightSizeMultiplier,
                right: .512 * SizeConfig.widthSizeMultiplier,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _review.images.removeAt(index);
                    _review.base64Images.removeAt(index);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.9),
                    borderRadius: BorderRadius.circular(
                        .1875 * SizeConfig.heightSizeMultiplier),
                  ),
                  padding:
                      EdgeInsets.all(.3125 * SizeConfig.heightSizeMultiplier),
                  child: Icon(
                    Icons.close,
                    size: 5.12 * SizeConfig.imageSizeMultiplier,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> selectImages() async {
    List<Asset> _results;

    try {
      _results = await MultiImagePicker.pickImages(
        maxImages: 20,
        enableCamera: true,
      );
    } catch (error) {
      print(error);
    }

    if (_results != null) {
      for (int i = 0; i < _results.length; i++) {
        final filePath =
            await FlutterAbsolutePath.getAbsolutePath(_results[i].identifier);

        ImageCompressor.compress(File(filePath), 50).then((file) {
          file.readAsBytes().then((fileInByte) {
            _review.base64Images.add(base64Encode(fileInByte));
          });

          setState(() {
            _review.images.add(file.path);
          });
        });
      }
    }
  }

  void _validate(BuildContext context) {
    if (_review.rating == 0) {
      _showToast(AppLocalization.of(context).getTranslatedValue("give_rating"),
          Toast.LENGTH_SHORT);
    } else {
      if (_review.comment == null || _review.comment.isEmpty) {
        _showToast(
            AppLocalization.of(context).getTranslatedValue("add_comment"),
            Toast.LENGTH_SHORT);
      } else {
        _presenter.submitReview(context, widget.product.id, _review);
      }
    }
  }

  void _showToast(String message, Toast length) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(.8),
      textColor: Colors.white,
      fontSize: 2 * SizeConfig.textSizeMultiplier,
    );
  }

  @override
  void onDisconnected(BuildContext context) {
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("not_connected"));
  }

  @override
  void onInactive(BuildContext context) {
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("inactive_connection"));
  }

  @override
  void onTimeout(BuildContext context) {
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("connection_time_out"));
  }

  @override
  void onReviewSubmitted(BuildContext context) {
    Navigator.pop(context,
        AppLocalization.of(context).getTranslatedValue("review_submitted"));
  }

  @override
  void onFailedToSubmitReview(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  @override
  void failedToGetReviews(BuildContext context) {}

  @override
  void showAllReview(List<Review> reviews) {}
}
