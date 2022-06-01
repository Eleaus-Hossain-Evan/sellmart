import 'package:flutter/material.dart';
import '../contract/category_contract.dart';
import '../contract/connectivity_contract.dart';
import '../localization/app_localization.dart';
import '../model/category.dart';
import '../model/sub_sub_category.dart';
import '../presenter/data_presenter.dart';
import '../utils/size_config.dart';
import '../widget/category_list_view.dart';
import '../widget/error_widget.dart';
import '../widget/my_app_bar.dart';
import '../widget/sub_category_expand_list.dart';

GlobalKey<_CategoriesState> categoriesKey = GlobalKey();
ValueNotifier<bool> isCategoriesLoaded = ValueNotifier(false);

class Categories extends StatefulWidget {

  Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> implements Connectivity, CategoryContract {

  DataPresenter _presenter;

  CategoryContract _contract;
  Connectivity _connectivity;

  int _selectedCategoryIndex;

  List<Category> _categories;


  @override
  void initState() {

    _connectivity = this;
    _contract = this;
    _presenter = DataPresenter(_connectivity, categoryContract: _contract);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Builder(
          builder: (BuildContext context) {

            return SafeArea(
              child: Stack(
                children: <Widget>[

                  _categories == null ? Container() : Padding(
                    padding: EdgeInsets.only(
                      top: 6.875 * SizeConfig.heightSizeMultiplier,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        CategoryListView(_categories, _selectedCategoryIndex,
                          onCategorySelected: (int index) {
                            setState(() {
                              _selectedCategoryIndex = index;
                            });
                          },
                        ),

                        SubCategoryExpandList(_categories, _selectedCategoryIndex),
                      ],
                    ),
                  ),

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("categories"),
                    autoImplyLeading: false,
                    onBackPress: () {

                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  void reloadPage() {

    if(!isCategoriesLoaded.value) {

      _selectedCategoryIndex = null;
      _categories = null;

      if(mounted) {
        setState(() {});
      }

      _presenter.getAllCategory(context);
    }
  }


  Future<bool> _onBackPress() {

    return Future(() => false);
  }


  @override
  void dispose() {

    _presenter.hideOverlayLoader();
    super.dispose();
  }


  @override
  void onDisconnected(BuildContext context) {

    isCategoriesLoaded.value = false;

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("not_connected"));
    }
  }


  @override
  void onFailure(BuildContext context) {

    isCategoriesLoaded.value = false;

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("could_not_load_data"));
    }
  }


  @override
  void onInactive(BuildContext context) {

    isCategoriesLoaded.value = false;

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("inactive_connection"));
    }
  }


  @override
  void onTimeout(BuildContext context) {

    isCategoriesLoaded.value = false;

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("connection_time_out"));
    }
  }


  @override
  void onSuccess(List<Category> categories) {

    categories.sort((a,b) => a.name.compareTo(b.name));

    this._categories = categories;

    categories.forEach((category) {

      if(category != null && category.subCategories != null) {

        category.subCategories.forEach((subCategory) {

          subCategory.subSubCategories.insert(0, SubSubCategory(name: AppLocalization.of(context).getTranslatedValue("all")));
        });
      }
    });

    _selectedCategoryIndex = 0;

    if(mounted) {
      setState(() {});
    }

    isCategoriesLoaded.value = true;
  }


  Future<Widget> _showErrorDialog(BuildContext mainContext, String subTitle) async {

    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return MyErrorWidget(
            subTitle: subTitle,
            onPressed: () {

              _presenter.getAllCategory(mainContext);
            },
          );
        }
    );
  }
}