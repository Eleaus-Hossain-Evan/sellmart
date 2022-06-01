import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../localization/app_localization.dart';
import '../model/user.dart';
import '../presenter/user_presenter.dart';
import '../resources/images.dart';
import '../utils/api_routes.dart';
import '../utils/size_config.dart';

class UserImage extends StatefulWidget {

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: currentUser,
      builder: (BuildContext context, User user, _) {

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),

            user.image != null && user.image.isNotEmpty ? Container(
              width: 19.23 * SizeConfig.widthSizeMultiplier,
              height: 9.375 * SizeConfig.heightSizeMultiplier,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: ExtendedNetworkImageProvider(user.image != null && user.image.isNotEmpty ? APIRoute.BASE_URL + user.image : (APIRoute.BASE_URL + ""),
                    cache: true,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ) : ClipOval(
              child: Image.asset(Images.userIcon,
                width: 20.51 * SizeConfig.widthSizeMultiplier,
                height: 10 * SizeConfig.heightSizeMultiplier,
              ),
            ),

            SizedBox(height: 1.875 * SizeConfig.heightSizeMultiplier,),

            Text(user.firstName == null ? AppLocalization.of(context).getTranslatedValue("you_are_not_logged_in").toUpperCase() : user.firstName + " " + user.lastName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        );
      },
    );
  }
}