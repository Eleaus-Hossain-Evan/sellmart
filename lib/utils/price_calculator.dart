import '../model/variation.dart';

import '../model/discount.dart';

class PriceCalculator {

  static const int AMOUNT = 1;
  static const int PERCENTAGE = 2;

  double getPrice(Discount discount, double originalPrice) {

    double price = originalPrice;

    try {

      if(discount != null) {

        if(discount.type == AMOUNT) {

          price = originalPrice - discount.amount;
        }
        else if(discount.type == PERCENTAGE) {

          price = originalPrice - ((originalPrice * discount.amount) / 100);
        }
      }
    }
    catch(error) {

      print(error);
      price = originalPrice;
    }

    return price;
  }

  double getDiscount(Variation variation) {

    double discount = 0;

    try {

      if(variation != null) {

        if(variation.regularPrice != variation.discountPrice) {

          discount = ((variation.regularPrice - variation.discountPrice) * 100) / variation.regularPrice;
        }
      }
    }
    catch(error) {

      print(error);
    }

    return discount;
  }
}