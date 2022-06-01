import '../model/app_service.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {

  final AppService service;

  ServiceWidget(this.service);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Material(
          elevation: 1,
          color: Colors.white,
          shadowColor: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(6.25 * SizeConfig.heightSizeMultiplier),
          child: ClipOval(
            child: Image.asset(service.image,
              height: 7.5 * SizeConfig.heightSizeMultiplier,
              width: 15.38 * SizeConfig.widthSizeMultiplier,
              fit: BoxFit.fill,
            ),
          ),
        ),

        SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

        Container(
          width: 16.66 * SizeConfig.widthSizeMultiplier,
          alignment: Alignment.center,
          child: Text(service.name ?? "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 1.4 * SizeConfig.textSizeMultiplier,
                fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}