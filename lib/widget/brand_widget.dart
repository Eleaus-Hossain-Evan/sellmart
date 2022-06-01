import '../utils/api_routes.dart';

import '../model/brand.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class BrandWidget extends StatelessWidget {

  final Brand brand;

  BrandWidget(this.brand);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Card(
          elevation: 2,
          color: Colors.white,
          child: Container(
            width: 24 * SizeConfig.widthSizeMultiplier,
            height: 15 * SizeConfig.heightSizeMultiplier,
            child: Column(
              children: <Widget>[

                Expanded(
                  flex: 9,
                  child: Image.network(this.brand.image ?? (APIRoute.BASE_URL + ""),
                    cacheHeight: 200,
                    cacheWidth: 200,
                    scale: .5,
                    fit: BoxFit.fill,
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: .625 * SizeConfig.heightSizeMultiplier),
                    child: Text(this.brand.name ?? "",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 1.625 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}