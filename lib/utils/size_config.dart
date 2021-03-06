import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";

class SizeConfig {

  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textSizeMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightSizeMultiplier = 0;
  static double widthSizeMultiplier = 0;

  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {

    if (orientation == Orientation.portrait) {

      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;

      if (_screenWidth < 450) {

        isMobilePortrait = true;
      }
    }
    else {

      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textSizeMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightSizeMultiplier = _blockHeight;
    widthSizeMultiplier = _blockWidth;

    print(_blockHeight);
    print(_blockWidth);
  }
}