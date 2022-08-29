import 'package:app/model/variation.dart';
import 'package:app/view/product_details.dart';
import 'package:logger/logger.dart';

import '../model/product.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class ProductSizeInfo extends StatefulWidget {
  final Product product;

  ProductSizeInfo(this.product);

  @override
  _ProductSizeInfoState createState() => _ProductSizeInfoState();
}

class _ProductSizeInfoState extends State<ProductSizeInfo> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.product != null &&
              widget.product.variationType != null &&
              widget.product.variationType == 2 &&
              widget.product.sizeInfos != null &&
              widget.product.sizeInfos.length > 0 &&
              widget.product.sizeInfos[0].infos.length > 1,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 1.875 * SizeConfig.heightSizeMultiplier,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Wrap(
                      children: widget.product != null &&
                              widget.product.variationType != null &&
                              widget.product.variationType == 2 &&
                              widget.product.sizeInfos != null &&
                              widget.product.sizeInfos.length > 0
                          ? widget.product.sizeInfos[0].infos
                              .asMap()
                              .map((index, item) => MapEntry(
                                  index,
                                  Visibility(
                                    visible: index > 0,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        _onValueSelected(item[1]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          top: .825 *
                                              SizeConfig.heightSizeMultiplier,
                                          bottom: .825 *
                                              SizeConfig.heightSizeMultiplier,
                                          left: 2.5 *
                                              SizeConfig.widthSizeMultiplier,
                                          right: 2.5 *
                                              SizeConfig.widthSizeMultiplier,
                                        ),
                                        margin: EdgeInsets.only(
                                          right: 3 *
                                              SizeConfig.widthSizeMultiplier,
                                          bottom: 2 *
                                              SizeConfig.heightSizeMultiplier,
                                        ),
                                        decoration: BoxDecoration(
                                          color: widget.product
                                                          .selectedSizeItem !=
                                                      null &&
                                                  widget.product
                                                          .selectedSizeItem ==
                                                      item[1]
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey[300],
                                          borderRadius: BorderRadius.circular(
                                              .25 *
                                                  SizeConfig
                                                      .heightSizeMultiplier),
                                        ),
                                        child: Text(
                                          item[1],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                  color: widget.product
                                                                  .selectedSizeItem !=
                                                              null &&
                                                          widget.product
                                                                  .selectedSizeItem ==
                                                              item[1]
                                                      ? Colors.white
                                                      : Colors.black
                                                          .withOpacity(.75),
                                                  fontSize: 1.75 *
                                                      SizeConfig
                                                          .textSizeMultiplier,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  )))
                              .values
                              .toList()
                          : List.generate(0, (index) {
                              return Container();
                            }),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.875 * SizeConfig.heightSizeMultiplier,
              ),
              widget.product.sizeInfos.isNotEmpty
                  ? _buildTable(widget.product.sizeInfos[0].infos)
                  : SizedBox.shrink(),
              SizedBox(
                height: 1.875 * SizeConfig.heightSizeMultiplier,
              ),
              _divider(),
            ],
          ),
        ),
        Visibility(
          visible: widget.product != null &&
              widget.product.variationType != null &&
              widget.product.variationType == 1 &&
              widget.product.variations != null &&
              widget.product.variations.length > 0 &&
              widget.product.variations[0].id.isNotEmpty,
          child: _VariationItems(
            product: widget.product,
          ),
        ),
      ],
    );
  }

  Widget _buildTable(List<List<String>> list) {
    // return DataTable(
    //   horizontalMargin: 0,
    //   showCheckboxColumn: false,
    //   columnSpacing: 1.5 * SizeConfig.widthSizeMultiplier,
    //   onSelectAll: (bool value) {
    //     debugPrint('select-all: $value');
    //   },
    //   columns: List.generate(
    //     list[0].length,
    //     (index) => DataColumn(
    //       label: Text(list[0][index]),
    //       tooltip: list[0][index],
    //     ),
    //   ),
    //   rows: list.map<DataRow>((e) {
    //     return DataRow(
    //       onSelectChanged: (bool selected) {
    //         debugPrint('row-selected: ${e.map((e) => e)}');
    //       },
    //       selected: widget.product.selectedSizeItem == e[1],
    //       cells: List.generate(
    //         e.length,
    //         (index) => DataCell(
    //           Center(child: Text(e[index])),
    //           onTap: () => _onValueSelected(e[1]),
    //         ),
    //       ),
    //     );
    //   }).toList(),
    // );

    return Table(
      border: TableBorder.all(
        color: Theme.of(context).primaryColor,
        width: .25 * SizeConfig.widthSizeMultiplier,
      ),
      defaultColumnWidth: IntrinsicColumnWidth(flex: 1),
      children: List.generate(
        list.length,
        (index) {
          final e = list[index];
          final isTop = index == 0;
          return TableRow(
            decoration: BoxDecoration(
              color: widget.product.selectedSizeItem != null &&
                      widget.product.selectedSizeItem == e[1]
                  ? Theme.of(context).primaryColor
                  : Colors.grey[300],
            ),
            children: List.generate(
              e.length,
              (index) => GestureDetector(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1 * SizeConfig.widthSizeMultiplier,
                    vertical: .5 * SizeConfig.heightSizeMultiplier,
                  ),
                  child: Center(
                    child: Text(
                      e[index],
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: widget.product.selectedSizeItem != null &&
                                  widget.product.selectedSizeItem == e[1]
                              ? Colors.white
                              : Colors.black.withOpacity(.75),
                          fontSize: isTop
                              ? 1.8 * SizeConfig.textSizeMultiplier
                              : 2 * SizeConfig.textSizeMultiplier,
                          fontWeight:
                              isTop ? FontWeight.bold : FontWeight.w500),
                    ),
                  ),
                ),
                onTap: () {
                  if (!isTop) {
                    _onValueSelected(e[1]);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _divider() {
    return Container(
      color: Theme.of(context).hintColor,
      height: .625 * SizeConfig.heightSizeMultiplier,
      width: double.infinity,
    );
  }

  void _onValueSelected(String itemName) {
    if (itemName != widget.product.selectedSizeItem) {
      setState(() {
        widget.product.selectedSizeItem = itemName;
      });

      for (int i = 1; i < widget.product.sizeInfos[0].infos.length; i++) {
        if (widget.product.sizeInfos[0].infos[i][1] == itemName) {
          if (int.parse(widget.product.sizeInfos[0].infos[i][0]) > 0) {
            if (widget.product.quantity >
                int.parse(widget.product.sizeInfos[0].infos[i][0])) {
              setState(() {
                widget.product.quantity =
                    int.parse(widget.product.sizeInfos[0].infos[i][0]);
              });
            }
          } else {
            setState(() {
              widget.product.quantity = 1;
            });
          }

          break;
        }
      }
    }
  }
}

class _VariationItems extends StatefulWidget {
  _VariationItems({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  __VariationItemsState createState() => __VariationItemsState();
}

class __VariationItemsState extends State<_VariationItems> {
  final _selectedValue1 = ValueNotifier('');

  var _value1 = <String>[];

  var _value2 = <Variation>[];

  @override
  void initState() {
    _selectedValue1.value = widget.product.selectedVariation != null
        ? widget.product.selectedVariation.value1
        : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _value1 = widget.product.variations
        .map((element) => element.value1)
        .toSet()
        .toList();
    // Logger().i(_value1.toString());
    // Logger().i('selectedValue: ${_selectedValue1.value}');

    _value2 = widget.product.variations
        .where((element) => element.value1 == _selectedValue1.value)
        .toSet()
        .toList();
    // Logger().d('_value2: $_value2');
    // Logger().d('_value2: ${_value2.length}');
    return Column(
      children: <Widget>[
        SizedBox(
          height: 1.875 * SizeConfig.heightSizeMultiplier,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Wrap(
                children: widget.product.variations[0].id.isNotEmpty &&
                        _value1.isNotEmpty
                    ? List.generate(
                        _value1.length,
                        (index) {
                          final e = _value1[index];
                          return e.isNotEmpty
                              ? GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    // _onVariationSelected(item);
                                    _selectedValue1.value = e;
                                    setState(() {});
                                    print('_selectedValue1: $_selectedValue1');
                                    // _selectedValue1.notifyListeners();
                                    if (_value2.any(
                                        (element) => element.value2.isEmpty)) {
                                      _onVariationSelected(widget
                                          .product.variations
                                          .firstWhere((element) =>
                                              element.value1 ==
                                              _selectedValue1.value));
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: .825 *
                                          SizeConfig.heightSizeMultiplier,
                                      horizontal:
                                          2.5 * SizeConfig.widthSizeMultiplier,
                                    ),
                                    margin: EdgeInsets.only(
                                      right: 3 * SizeConfig.widthSizeMultiplier,
                                      bottom:
                                          2 * SizeConfig.heightSizeMultiplier,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _selectedValue1.value == e
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(.25 *
                                          SizeConfig.heightSizeMultiplier),
                                    ),
                                    child: Text(
                                      e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                              color: _selectedValue1.value == e
                                                  ? Colors.white
                                                  : Colors.black
                                                      .withOpacity(.75),
                                              fontSize: 1.75 *
                                                  SizeConfig.textSizeMultiplier,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink();
                        },
                      )
                    : SizedBox.shrink(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1.875 * SizeConfig.heightSizeMultiplier,
        ),
        widget.product.variations.isNotEmpty && _value2.isNotEmpty
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: List.generate(
                    _value2.length,
                    (index) {
                      final e = _value2[index];
                      return e.value2.isNotEmpty
                          ? GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => _onVariationSelected(e),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      .825 * SizeConfig.heightSizeMultiplier,
                                  horizontal:
                                      2.5 * SizeConfig.widthSizeMultiplier,
                                ),
                                margin: EdgeInsets.only(
                                  right: 3 * SizeConfig.widthSizeMultiplier,
                                  bottom: 2 * SizeConfig.heightSizeMultiplier,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.product.selectedVariation.id ==
                                          e.id
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(
                                    .25 * SizeConfig.heightSizeMultiplier,
                                  ),
                                ),
                                child: Text(
                                  e.value2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: widget.product.selectedVariation
                                                    .id ==
                                                e.id
                                            ? Colors.white
                                            : Colors.black.withOpacity(.75),
                                        fontSize: 1.75 *
                                            SizeConfig.textSizeMultiplier,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            )
                          : SizedBox.shrink();
                    },
                  ),
                ),
              )
            : SizedBox.shrink(),
        SizedBox(
          height: 1.875 * SizeConfig.heightSizeMultiplier,
        ),
      ],
    );
  }

  void _onVariationSelected(Variation variation) {
    if (variation.id != widget.product.selectedVariation.id) {
      setState(() {
        widget.product.selectedVariation = variation;
        onSelectedVariation.value = variation;
      });

      // onSelectedVariation.notifyListeners();
      Logger().v('onSelectedVariation: ${variation}');
      for (int i = 1; i < widget.product.variations.length; i++) {
        if (widget.product.variations[i].id == variation.id) {
          if (widget.product.variations[i].stock > 0) {
            if (widget.product.quantity > widget.product.variations[i].stock) {
              setState(() {
                widget.product.quantity = widget.product.variations[i].stock;
                widget.product.currentPrice =
                    onSelectedVariation.value.discountPrice;
              });
            }
          } else {
            setState(() {
              widget.product.quantity = 1;
            });
          }

          break;
        }
      }
    }
  }
}
