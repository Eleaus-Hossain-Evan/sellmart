import '../widget/my_button.dart';

import '../utils/my_flush_bar.dart';
import '../widget/error_widget.dart';

import '../contract/connectivity_contract.dart';
import '../contract/location_contract.dart';
import '../contract/profile_contract.dart';
import '../localization/app_localization.dart';
import '../model/address.dart';
import '../model/district.dart';
import '../model/division.dart';
import '../model/upazilla.dart';
import '../presenter/data_presenter.dart';
import '../presenter/user_presenter.dart';
import '../utils/shared_preference.dart';
import '../utils/size_config.dart';
import '../widget/address_list_view.dart';
import '../widget/my_app_bar.dart';
import 'package:flutter/material.dart';

import 'add_address.dart';

class MyAddress extends StatefulWidget {

  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> with ChangeNotifier implements Connectivity, LocationContract, ProfileContract {

  DataPresenter _dataPresenter;
  UserPresenter _userPresenter;

  Connectivity _connectivity;
  LocationContract _locationContract;
  ProfileContract _profileContract;

  List<Division> _divisionList;

  MySharedPreference _sharedPreference = MySharedPreference();

  ValueNotifier<int> addressIndex = ValueNotifier(0);


  @override
  void initState() {

    _connectivity = this;
    _locationContract = this;
    _profileContract = this;

    _dataPresenter = DataPresenter(_connectivity, locationContract: _locationContract);
    _userPresenter = UserPresenter(_connectivity, profileContract: _profileContract);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      _dataPresenter.getLocations(context);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (BuildContext context) {

            return SafeArea(
              child: Column(
                children: <Widget>[

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("addresses"),
                    onBackPress: () {

                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),

                  Expanded(
                    child: Stack(
                      children: <Widget>[

                        Visibility(
                          visible: _divisionList != null,
                          child: AddressListView(
                            onEdit: (Address address) {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress(divisionList: _divisionList, address: address)));
                            },
                            onDelete: (String addressID) {

                              _userPresenter.deleteAddress(context, addressID);
                            },
                          ),
                        ),

                        Visibility(
                          visible: _divisionList != null,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 2 * SizeConfig.heightSizeMultiplier,
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: MyButton(AppLocalization.of(context).getTranslatedValue("add_address"),
                                marginLeft: 5.12,
                                marginRight: 5.12,
                                onPressed: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress(divisionList: _divisionList)));
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  Future<bool> _onBackPress() {

    Navigator.pop(context);
    return Future(() => false);
  }


  @override
  void dispose() {

    _userPresenter.hideOverlayLoader();
    _dataPresenter.hideOverlayLoader();

    super.dispose();
  }


  @override
  void onDisconnected(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("not_connected"));
    }
  }


  @override
  void onInactive(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("inactive_connection"));
    }
  }


  @override
  void onTimeout(BuildContext context) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("connection_time_out"));
    }
  }


  @override
  void onFailedToGetLocations(BuildContext context, String message, int errorType) {

    if(mounted) {
      _showErrorDialog(context, AppLocalization.of(context).getTranslatedValue("could_not_load_data"));
    }
  }


  @override
  void onLocationsFetched(List<Division> divisions, List<District> districts, List<Upazila> upazilas) {

    divisions.forEach((division) {

      division.districtList = List();

      districts.forEach((district) {

        if(division.id == district.divisionID) {

          district.upazilaList = List();

          upazilas.forEach((upazila) {

            if(district.id == upazila.districtID) {

              district.upazilaList.add(upazila);
            }
          });

          division.districtList.add(district);
        }
      });
    });

    this._divisionList = divisions;

    setState(() {});
  }


  @override
  void onFailed(BuildContext context, String message) {

    MyFlushBar.show(context, message);
  }


  @override
  void onProfileUpdated(BuildContext context, String message) {}


  @override
  void onAddressAdded(BuildContext context) {}


  @override
  void onAddressDeleted(BuildContext context, int position) {

    MyFlushBar.show(context, AppLocalization.of(context).getTranslatedValue("address_deleted"));

    currentUser.value.addresses.list.removeAt(position);
    currentUser.notifyListeners();

    _sharedPreference.setCurrentUser(currentUser.value);
  }


  @override
  void onAddressUpdated(BuildContext context) {}


  Future<Widget> _showErrorDialog(BuildContext mainContext, String subTitle) async {

    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return MyErrorWidget(
            subTitle: subTitle,
            onPressed: () {

              _dataPresenter.getLocations(mainContext);
            },
          );
        }
    );
  }
}