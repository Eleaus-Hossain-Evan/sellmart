import '../localization/app_localization.dart';

import '../model/address.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class DeliveryAddressWidget extends StatefulWidget {

  final bool isSelection;
  final double elevation;
  final Address address;
  final void Function(Address) onEdit;
  final void Function(String addressID) onDelete;

  DeliveryAddressWidget(this.address, this.isSelection, {this.elevation = 2, this.onEdit, this.onDelete});

  @override
  _DeliveryAddressWidgetState createState() => _DeliveryAddressWidgetState();
}

class _DeliveryAddressWidgetState extends State<DeliveryAddressWidget> {

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: widget.address.id != null && widget.address.id.isNotEmpty,
      child: Card(
        elevation: widget.elevation,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.all(1.875 * SizeConfig.heightSizeMultiplier,),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Flexible(
                    child: Text(widget.address.name ?? "",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.7),
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(height: 1.5 * SizeConfig.heightSizeMultiplier,),

                  Flexible(
                    child: Text(widget.address.phone ?? "",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.55),
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(height: 1.5 * SizeConfig.heightSizeMultiplier,),

                  Flexible(
                    child: Text(widget.address.details ?? "",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.55),
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),

                  Flexible(
                    child: Text(AppLocalization.of(context).getTranslatedValue("upazila") + ":  " + (widget.address.upazila ?? ""),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.55),
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),

                  Flexible(
                    child: Text(AppLocalization.of(context).getTranslatedValue("district") + ":  " + (widget.address.district ?? ""),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.55),
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),

                  Flexible(
                    child: Text(AppLocalization.of(context).getTranslatedValue("division") + ":  " + (widget.address.division ?? ""),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.55),
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            Visibility(
              visible: !widget.isSelection,
              child: Column(
                children: <Widget>[

                  Container(
                    height: 1.5,
                    color: Theme.of(context).hintColor,
                  ),

                  IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {

                              widget.onEdit(widget.address);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 1 * SizeConfig.heightSizeMultiplier,
                                bottom: 1 * SizeConfig.heightSizeMultiplier,
                              ),
                              child: Text(AppLocalization.of(context).getTranslatedValue("edit"),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          width: .45 * SizeConfig.widthSizeMultiplier,
                          color: Theme.of(context).hintColor,
                        ),

                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {

                              widget.onDelete(widget.address.id);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 1 * SizeConfig.heightSizeMultiplier,
                                bottom: 1 * SizeConfig.heightSizeMultiplier,
                              ),
                              child: Text(AppLocalization.of(context).getTranslatedValue("remove"),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
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
      ),
    );
  }
}