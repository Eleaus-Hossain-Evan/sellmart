import 'package:flutter/material.dart';
import '../model/category.dart';
import '../model/sub_category.dart';
import '../utils/size_config.dart';
import '../view/products.dart';

class SubCategoryExpandList extends StatefulWidget {

  final List<Category> categories;
  final int selectedCategoryIndex;

  SubCategoryExpandList(this.categories, this.selectedCategoryIndex);

  @override
  _SubCategoryExpandListState createState() =>_SubCategoryExpandListState();
}

class _SubCategoryExpandListState extends State<SubCategoryExpandList> {

  @override
  Widget build(BuildContext context) {

    return Expanded(
      flex: 2,
      child: Container(
        color: Theme.of(context).hintColor,
        padding: EdgeInsets.all(1.875 * SizeConfig.heightSizeMultiplier),
        child: Visibility(
          visible: widget.categories != null && widget.selectedCategoryIndex != null && widget.categories[widget.selectedCategoryIndex].subCategories.length > 0,
          child: Container(
            padding: EdgeInsets.all(.625 * SizeConfig.heightSizeMultiplier),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
            ),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowGlow();
                return;
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.categories != null && widget.selectedCategoryIndex != null ? widget.categories[widget.selectedCategoryIndex].subCategories.length : 0,
                itemBuilder: (BuildContext context, int subIndex) {

                  SubCategory subCategory = widget.categories[widget.selectedCategoryIndex].subCategories[subIndex];

                  return ExpansionTile(
                    key: PageStorageKey<SubCategory>(subCategory),
                    title: Text(subCategory.name,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 1.65 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    children: List.generate(subCategory.subSubCategories.length, (int subSubIndex) {

                      return Column(
                        children: [

                          ListTile(
                            onTap: () {

                              _onSelected(subSubIndex, subCategory);
                            },
                            dense: true,
                            title: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                  Row(
                                    children: [

                                      SizedBox(width: 1.79 * SizeConfig.widthSizeMultiplier,),

                                      Text("•",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.headline1.copyWith(
                                          fontSize: 1.65 * SizeConfig.textSizeMultiplier,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.blue,
                                        ),
                                      ),

                                      SizedBox(width: 1.28 * SizeConfig.widthSizeMultiplier,),

                                      Flexible(
                                        child: Text(subCategory.subSubCategories[subSubIndex].name,
                                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                            fontSize: 1.65 * SizeConfig.textSizeMultiplier,
                                            fontWeight: subSubIndex == 0 ? FontWeight.w500 : FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Visibility(
                                    visible: subSubIndex < subCategory.subSubCategories.length - 1,
                                    child: SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier),
                                  ),

                                  Visibility(
                                    visible: subSubIndex < subCategory.subSubCategories.length - 1,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 1.79 * SizeConfig.widthSizeMultiplier,
                                        right: 1.79 * SizeConfig.widthSizeMultiplier,
                                      ),
                                      height: .07 * SizeConfig.heightSizeMultiplier,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }


  void _onSelected(int subSubIndex, SubCategory subCategory) {

    if(subSubIndex == 0) {

      Navigator.push(context, MaterialPageRoute(builder: (context) => Products(subCategory: subCategory)));
    }
    else {

      Navigator.push(context, MaterialPageRoute(builder: (context) => Products(subSubCategory: subCategory.subSubCategories[subSubIndex])));
    }
  }
}