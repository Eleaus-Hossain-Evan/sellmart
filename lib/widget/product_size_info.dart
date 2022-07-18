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
    return Visibility(
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
                                      left:
                                          2.5 * SizeConfig.widthSizeMultiplier,
                                      right:
                                          2.5 * SizeConfig.widthSizeMultiplier,
                                    ),
                                    margin: EdgeInsets.only(
                                      right: 3 * SizeConfig.widthSizeMultiplier,
                                      bottom:
                                          2 * SizeConfig.heightSizeMultiplier,
                                    ),
                                    decoration: BoxDecoration(
                                      color: widget.product.selectedSizeItem !=
                                                  null &&
                                              widget.product.selectedSizeItem ==
                                                  item[1]
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(.25 *
                                          SizeConfig.heightSizeMultiplier),
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
                                                  SizeConfig.textSizeMultiplier,
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
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.product != null &&
                          widget.product.sizeInfos != null &&
                          widget.product.sizeInfos.length > 0 &&
                          widget.product.sizeInfos[0].infos != null
                      ? widget.product.sizeInfos[0].infos.length
                      : 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Visibility(
                      visible: index == 0 ||
                          (widget.product.sizeInfos[0].infos[index][1] ==
                              widget.product.selectedSizeItem),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                            widget.product.sizeInfos[0].infos[0].length,
                            (itemIndex) {
                          return Flexible(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                vertical: .8 * SizeConfig.heightSizeMultiplier,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: index == 0
                                      ? BorderSide(
                                          width: .25 *
                                              SizeConfig.widthSizeMultiplier,
                                          color: Theme.of(context).primaryColor)
                                      : BorderSide.none,
                                  bottom: BorderSide(
                                      width:
                                          .25 * SizeConfig.widthSizeMultiplier,
                                      color: Theme.of(context).primaryColor),
                                  left: itemIndex == 0
                                      ? BorderSide(
                                          width: .25 *
                                              SizeConfig.widthSizeMultiplier,
                                          color: Theme.of(context).primaryColor)
                                      : BorderSide.none,
                                  right: BorderSide(
                                      width:
                                          .25 * SizeConfig.widthSizeMultiplier,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.product.sizeInfos[0].infos[index]
                                          [itemIndex],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                            fontWeight: index == 0
                                                ? FontWeight.w700
                                                : FontWeight.w400,
                                            fontSize: 1.75 *
                                                SizeConfig.textSizeMultiplier,
                                            color:
                                                Colors.black.withOpacity(.65),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
          SizedBox(
            height: 1.875 * SizeConfig.heightSizeMultiplier,
          ),
          _divider(),
        ],
      ),
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
                        fontWeight: isTop ? FontWeight.bold : FontWeight.w500),
                  )),
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

class Dessert {
  Dessert(this.name, this.calories, this.fat, this.carbs, this.protein,
      this.sodium, this.calcium, this.iron);

  final String name;
  final int calories;
  final double fat;
  final int carbs;
  final double protein;
  final int sodium;
  final int calcium;
  final int iron;
}

final List<Dessert> kDesserts = <Dessert>[
  Dessert('Frozen yogurt', 159, 6.0, 24, 4.0, 87, 14, 1),
  Dessert('Ice cream sandwich', 237, 9.0, 37, 4.3, 129, 8, 1),
  Dessert('Eclair', 262, 16.0, 24, 6.0, 337, 6, 7),
  Dessert('Cupcake', 305, 3.7, 67, 4.3, 413, 3, 8),
  Dessert('Gingerbread', 356, 16.0, 49, 3.9, 327, 7, 16),
  Dessert('Jelly bean', 375, 0.0, 94, 0.0, 50, 0, 0),
  Dessert('Lollipop', 392, 0.2, 98, 0.0, 38, 0, 2),
  Dessert('Honeycomb', 408, 3.2, 87, 6.5, 562, 0, 45),
  Dessert('Donut', 452, 25.0, 51, 4.9, 326, 2, 22),
  Dessert('KitKat', 518, 26.0, 65, 7.0, 54, 12, 6),
];
