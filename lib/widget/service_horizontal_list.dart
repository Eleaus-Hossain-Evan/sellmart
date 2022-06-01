import '../model/app_service.dart' as modelService;
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'service_widget.dart';

class ServiceHorizontalList extends StatefulWidget {

  final modelService.AppServices services;
  final void Function(modelService.AppService) onServiceSelected;

  ServiceHorizontalList(this.services, {this.onServiceSelected});

  @override
  _ServiceHorizontalListState createState() => _ServiceHorizontalListState();
}

class _ServiceHorizontalListState extends State<ServiceHorizontalList> {

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: widget.services != null && widget.services.list.length > 0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 1.5 * SizeConfig.heightSizeMultiplier,
            left: 2.56 * SizeConfig.widthSizeMultiplier,
            right: 2.56 * SizeConfig.widthSizeMultiplier,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.services != null && widget.services.list != null ? widget.services.list.length : 0, (index) =>

                Padding(
                  padding: EdgeInsets.only(right: index < widget.services.list.length - 1 ? 3.5 * SizeConfig.widthSizeMultiplier : 0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {

                      widget.onServiceSelected(widget.services.list[index]);
                    },
                    child: ServiceWidget(widget.services.list[index]),
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }
}