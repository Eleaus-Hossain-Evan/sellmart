// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'product.dart';

class CartItem {
  int position;
  Product product;
  bool isChecked;

  CartItem(this.position, this.product, this.isChecked);

  @override
  String toString() =>
      'CartItem(position: $position, product: ${product.toString()}, isChecked: $isChecked)';
}
