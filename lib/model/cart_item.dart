import 'product.dart';

class CartItem {

  int position;
  Product product;
  bool isChecked;

  CartItem(this.position, this.product, this.isChecked);
}