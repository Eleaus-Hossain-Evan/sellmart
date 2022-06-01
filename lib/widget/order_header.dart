import '../resources/images.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class OrderHeader extends StatefulWidget {

  final int index;

  OrderHeader(this.index);

  @override
  _OrderHeaderState createState() => _OrderHeaderState();
}

class _OrderHeaderState extends State<OrderHeader> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(
        left: 1.875 * SizeConfig.heightSizeMultiplier,
        right: 1.875 * SizeConfig.heightSizeMultiplier,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          Container(
            height: .0625 * SizeConfig.heightSizeMultiplier,
            width: double.infinity,
            color: Colors.grey[400],
          ),

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Container(
                height: 6.25 * SizeConfig.heightSizeMultiplier,
                width: 6.25 * SizeConfig.heightSizeMultiplier,
                padding: EdgeInsets.all(1.25 * SizeConfig.heightSizeMultiplier,),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(Images.address),
              ),

              Container(
                height: 6.25 * SizeConfig.heightSizeMultiplier,
                width: 6.25 * SizeConfig.heightSizeMultiplier,
                padding: EdgeInsets.all(1.25 * SizeConfig.heightSizeMultiplier,),
                decoration: BoxDecoration(
                  color: widget.index > 0 ? Theme.of(context).primaryColor : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[400], width: .077 * SizeConfig.widthSizeMultiplier,),
                ),
                child: Image.asset(widget.index > 0 ? Images.cardWhite : Images.card),
              ),

              Container(
                height: 6.25 * SizeConfig.heightSizeMultiplier,
                width: 6.25 * SizeConfig.heightSizeMultiplier,
                padding: EdgeInsets.all(1.25 * SizeConfig.heightSizeMultiplier,),
                decoration: BoxDecoration(
                  color: widget.index > 1 ? Theme.of(context).primaryColor : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[400], width: .077 * SizeConfig.widthSizeMultiplier,),
                ),
                child: Image.asset(widget.index > 1 ? Images.confirmationWhite : Images.confirmation),
              ),
            ],
          ),
        ],
      ),
    );
  }
}