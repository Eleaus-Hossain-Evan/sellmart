import '../resources/images.dart';
import '../utils/messaging.dart';
import '../view/home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class SupportTeamBottomSheet extends StatefulWidget {

  @override
  _SupportTeamBottomSheetState createState() => _SupportTeamBottomSheetState();
}

class _SupportTeamBottomSheetState extends State<SupportTeamBottomSheet> {

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        Padding(
          padding: EdgeInsets.only(
            top: 1.875 * SizeConfig.heightSizeMultiplier,
            bottom: 1.875 * SizeConfig.heightSizeMultiplier,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(AppLocalization.of(context).getTranslatedValue("24_7_support"),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),

        Container(
          height: .09375 * SizeConfig.heightSizeMultiplier,
          color: Colors.black12,
        ),

        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {

            _launchDial(info.value.phone ?? "");
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: 1.875 * SizeConfig.heightSizeMultiplier,
              bottom: 1.875 * SizeConfig.heightSizeMultiplier,
              left: 5.12 * SizeConfig.widthSizeMultiplier,
              right: 5.12 * SizeConfig.widthSizeMultiplier,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Image.asset(Images.telephone,
                  height: 3.375 * SizeConfig.heightSizeMultiplier,
                  width: 6.92 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),

                SizedBox(width: 2.56 * SizeConfig.widthSizeMultiplier,),

                Text(AppLocalization.of(context).getTranslatedValue("call") + ":  " + (info.value.phone ?? ""),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          height: .625 * SizeConfig.heightSizeMultiplier,
          color: Colors.black.withOpacity(.07),
        ),

        SizedBox(height: 1.875 * SizeConfig.heightSizeMultiplier,),

        Align(
          alignment: Alignment.center,
          child: Text("+8801925762255",
            style: Theme.of(context).textTheme.subtitle2.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
        ),

        SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

        Padding(
          padding: EdgeInsets.only(
            top: 1.875 * SizeConfig.heightSizeMultiplier,
            bottom: 1.875 * SizeConfig.heightSizeMultiplier,
            left: 5.12 * SizeConfig.widthSizeMultiplier,
            right: 5.12 * SizeConfig.widthSizeMultiplier,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  Messaging.launchMessenger();
                },
                child: Image.asset(Images.messenger,
                  height: 5.625 * SizeConfig.heightSizeMultiplier,
                  width: 11.53 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  Messaging.launchWhatsApp();
                },
                child: Image.asset(Images.whatsapp,
                  height: 5.625 * SizeConfig.heightSizeMultiplier,
                  width: 11.53 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  Messaging.launchViber();
                },
                child: Image.asset(Images.viber,
                  height: 5.625 * SizeConfig.heightSizeMultiplier,
                  width: 11.53 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  Messaging.launchImo();
                },
                child: Image.asset(Images.imo,
                  height: 5.625 * SizeConfig.heightSizeMultiplier,
                  width: 11.53 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),

        Container(
          height: .625 * SizeConfig.heightSizeMultiplier,
          color: Colors.black.withOpacity(.07),
        ),

        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {

            _launchMail(info.value.email ?? "");
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: 1.875 * SizeConfig.heightSizeMultiplier,
              bottom: 1.875 * SizeConfig.heightSizeMultiplier,
              left: 5.12 * SizeConfig.widthSizeMultiplier,
              right: 5.12 * SizeConfig.widthSizeMultiplier,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Image.asset(Images.email,
                  height: 3.375 * SizeConfig.heightSizeMultiplier,
                  width: 6.92 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),

                SizedBox(width: 2.56 * SizeConfig.widthSizeMultiplier,),

                Text(AppLocalization.of(context).getTranslatedValue("email") + ":  ",
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(info.value.email ?? "",
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),
      ],
    );
  }


  Future<void> _launchDial(String phone) async {

    String url = "tel:" + phone;

    if(await canLaunch(url)) {

      await launch(url);
    }
  }


  Future<void> _launchMail(String mail) async {

    String url = "mailto:" + mail;

    if(await canLaunch(url)) {

      await launch(url);
    }
  }
}