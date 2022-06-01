import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class SheetBackground extends StatefulWidget {

  final bool isOpen;
  final void Function() onTap;

  SheetBackground(this.isOpen, {this.onTap});

  @override
  _SheetBackgroundState createState() => _SheetBackgroundState();
}

class _SheetBackgroundState extends State<SheetBackground> {

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: widget.isOpen,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          widget.onTap();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(top: 15 * SizeConfig.heightSizeMultiplier),
          color: Color(0xb3212121).withOpacity(.45),
        ),
      ),
    );
  }
}