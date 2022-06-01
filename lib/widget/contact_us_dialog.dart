import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import '../view/home.dart';
import 'package:flutter/material.dart';

class ContactUsDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
      ),
      child: Container(
        padding: EdgeInsets.all(2.5 * SizeConfig.heightSizeMultiplier),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),

            Center(
              child: Text(AppLocalization.of(context).getTranslatedValue("contact_us"),
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),

            SizedBox(height: 3.5 * SizeConfig.heightSizeMultiplier,),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Icon(Icons.phone, size: 4.61 * SizeConfig.imageSizeMultiplier, color: Colors.grey,),

                SizedBox(width: 1.5 * SizeConfig.widthSizeMultiplier,),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(AppLocalization.of(context).getTranslatedValue("customer_care"),
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 1 * SizeConfig.heightSizeMultiplier,),

                    Text(info.value.phone ?? "",
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 3.125 * SizeConfig.heightSizeMultiplier,),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Icon(Icons.email, size: 4.61 * SizeConfig.imageSizeMultiplier, color: Colors.grey,),

                SizedBox(width: 1.5 * SizeConfig.widthSizeMultiplier,),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(AppLocalization.of(context).getTranslatedValue("email"),
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 1 * SizeConfig.heightSizeMultiplier,),

                    Text(info.value.email ?? "",
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 3.125 * SizeConfig.heightSizeMultiplier,),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Icon(Icons.location_on, size: 4.61 * SizeConfig.imageSizeMultiplier, color: Colors.grey,),

                SizedBox(width: 1.5 * SizeConfig.widthSizeMultiplier,),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(AppLocalization.of(context).getTranslatedValue("address"),
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 1 * SizeConfig.heightSizeMultiplier,),

                    Flexible(
                      child: Text(info.value.address ?? "",
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),
          ],
        ),
      ),
    );
  }
}