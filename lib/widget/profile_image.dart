import 'dart:convert';
import 'dart:io';

import '../model/user.dart';
import '../presenter/user_presenter.dart';
import '../utils/api_routes.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/image_compressor.dart';
import 'package:extended_image/extended_image.dart';

class ProfileImage extends StatefulWidget {

  final void Function(String) onSubmit;

  ProfileImage({this.onSubmit});

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: currentUser,
      builder: (BuildContext context, User user, _) {

        return Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(
                bottom: 7.1875 * SizeConfig.heightSizeMultiplier,
              ),
              child: Container(
                height: 15 * SizeConfig.heightSizeMultiplier,
                width: double.infinity,
                color: Colors.cyan[50],
              ),
            ),

            Container(
              height: 14.375 * SizeConfig.heightSizeMultiplier,
              width: 29.48 * SizeConfig.widthSizeMultiplier,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                image: DecorationImage(
                  image: ExtendedNetworkImageProvider(user.image == null ? (APIRoute.BASE_URL + "") : APIRoute.BASE_URL + user.image,
                    cache: true,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 1 * SizeConfig.heightSizeMultiplier,
                    right: 1 * SizeConfig.widthSizeMultiplier,
                  ),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {

                      _pickImage();
                    },
                    child: Material(
                      elevation: 5,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.875 * SizeConfig.heightSizeMultiplier),
                      child: Padding(
                        padding: EdgeInsets.all(.875 * SizeConfig.heightSizeMultiplier),
                        child: Icon(Icons.camera_alt, size: 4.10 * SizeConfig.imageSizeMultiplier, color: Colors.black,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  void _pickImage() async {

    try {

      var pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
      File file = await ImageCompressor.compress(File(pickedFile.path), 20);

      List<int> fileInByte = await file.readAsBytes();
      String fileInBase64 = base64Encode(fileInByte);

      widget.onSubmit(fileInBase64);

    } catch(error) {

      print(error);
    }
  }
}