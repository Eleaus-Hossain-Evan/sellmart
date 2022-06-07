import 'package:app/model/upazilla.dart';

import 'package:app/model/division.dart';

import 'package:app/model/district.dart';

import '../view/cart.dart';
import '../widget/my_button.dart';

import '../view/add_address.dart';
import '../model/order.dart';
import '../presenter/user_presenter.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'delivery_address_widget.dart';
import '../contract/location_contract.dart';
import '../widget/error_widget.dart';
import '../presenter/data_presenter.dart';
import '../contract/connectivity_contract.dart';
import '../contract/profile_contract.dart';
import '../utils/my_flush_bar.dart';
import '../utils/shared_preference.dart';
import 'address_list_view.dart';
import '../model/address.dart';

class OrderDeliveryAddressWidget extends StatefulWidget {
  @override
  _OrderDeliveryAddressWidgetState createState() =>
      _OrderDeliveryAddressWidgetState();
}

class _OrderDeliveryAddressWidgetState extends State<OrderDeliveryAddressWidget>
    with ChangeNotifier
    implements Connectivity, LocationContract, ProfileContract {
  DataPresenter _dataPresenter;
  UserPresenter _userPresenter;

  Connectivity _connectivity;
  LocationContract _locationContract;
  ProfileContract _profileContract;

  List<Division> _divisionList;

  MySharedPreference _sharedPreference = MySharedPreference();

  ValueNotifier<int> addressIndex = ValueNotifier(0);
  ValueNotifier<Address> orderAddress = ValueNotifier(Address());

  @override
  void initState() {
    _connectivity = this;
    _locationContract = this;
    _profileContract = this;

    _dataPresenter =
        DataPresenter(_connectivity, locationContract: _locationContract);
    _userPresenter =
        UserPresenter(_connectivity, profileContract: _profileContract);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dataPresenter.getLocations(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: order,
          builder: (BuildContext context, Order order, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 2.5 * SizeConfig.heightSizeMultiplier,
                  color: Theme.of(context).hintColor,
                ),
                SizedBox(
                  height: 2.5 * SizeConfig.heightSizeMultiplier,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.12 * SizeConfig.widthSizeMultiplier,
                    right: 5.12 * SizeConfig.widthSizeMultiplier,
                  ),
                  child: Text(
                    // AppLocalization.of(context)
                    //     .getTranslatedValue("delivery_address")
                    "Select Delivery Address",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                SizedBox(
                  height: 2.5 * SizeConfig.heightSizeMultiplier,
                ),
                Container(
                  height: .25 * SizeConfig.heightSizeMultiplier,
                  color: Theme.of(context).hintColor,
                ),
                // SizedBox(
                //   height: 2.5 * SizeConfig.heightSizeMultiplier,
                // ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     left: 5.12 * SizeConfig.widthSizeMultiplier,
                //     right: 5.12 * SizeConfig.widthSizeMultiplier,
                //   ),
                //   child: Row(
                //     children: [
                //       ValueListenableBuilder(
                //         valueListenable: currentUser,
                //         builder: (BuildContext context, User user, _) {
                //          order.address = user.addresses.list[addressIndex.value];

                //           return Visibility(
                //             visible: user.addresses.list.length > 1,
                //             child: Padding(
                //               padding: EdgeInsets.only(
                //                 right: 5.12 * SizeConfig.widthSizeMultiplier,
                //               ),
                //               child: GestureDetector(
                //                 behavior: HitTestBehavior.opaque,
                //                 onTap: () {
                //                   Navigator.of(context)
                //                       .pushNamed(RouteManager.SELECT_ADDRESS);
                //                 },
                //                 child: Container(
                //                   padding: EdgeInsets.only(
                //                     top: 1 * SizeConfig.heightSizeMultiplier,
                //                     bottom: 1 * SizeConfig.heightSizeMultiplier,
                //                     left: 2.56 * SizeConfig.widthSizeMultiplier,
                //                     right:
                //                         2.56 * SizeConfig.widthSizeMultiplier,
                //                   ),
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(
                //                         .45 * SizeConfig.heightSizeMultiplier),
                //                     border: Border.all(
                //                         color: Colors.black26,
                //                         width: .254 *
                //                             SizeConfig.widthSizeMultiplier),
                //                   ),
                //                   child: Container(
                //                     padding: EdgeInsets.all(
                //                         .1 * SizeConfig.heightSizeMultiplier),
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(.75 *
                //                           SizeConfig.heightSizeMultiplier),
                //                       border: Border.all(
                //                           color: Colors.black38,
                //                           width: .384 *
                //                               SizeConfig.widthSizeMultiplier),
                //                     ),
                //                     child: Icon(
                //                       Icons.location_on,
                //                       size: 5 * SizeConfig.widthSizeMultiplier,
                //                       color: Colors.black38,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           );
                //         },
                //       ),
                //       GestureDetector(
                //         behavior: HitTestBehavior.opaque,
                //         onTap: () {
                //           Navigator.of(context)
                //               .pushNamed(RouteManager.MY_ADDRESS);
                //         },
                //         child: Container(
                //           padding: EdgeInsets.only(
                //             top: 1 * SizeConfig.heightSizeMultiplier,
                //             bottom: 1 * SizeConfig.heightSizeMultiplier,
                //             left: 2.56 * SizeConfig.widthSizeMultiplier,
                //             right: 2.56 * SizeConfig.widthSizeMultiplier,
                //           ),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(
                //                 .45 * SizeConfig.heightSizeMultiplier),
                //             border: Border.all(
                //                 color: Colors.black26,
                //                 width: .254 * SizeConfig.widthSizeMultiplier),
                //           ),
                //           child: Container(
                //             padding: EdgeInsets.all(
                //                 .1 * SizeConfig.heightSizeMultiplier),
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(
                //                   .75 * SizeConfig.heightSizeMultiplier),
                //               border: Border.all(
                //                   color: Colors.black38,
                //                   width: .384 * SizeConfig.widthSizeMultiplier),
                //             ),
                //             child: Icon(
                //               Icons.add,
                //               size: 5 * SizeConfig.widthSizeMultiplier,
                //               color: Colors.black38,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 2.5 * SizeConfig.heightSizeMultiplier,
                // ),
                // Visibility(
                //   visible: order.address != null,
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //       left: 1.5 * SizeConfig.heightSizeMultiplier,
                //       right: 1.5 * SizeConfig.heightSizeMultiplier,
                //     ),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[
                //         DeliveryAddressWidget(order.address, true),
                //         SizedBox(
                //           height: 1.875 * SizeConfig.heightSizeMultiplier,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Visibility(
                  visible: _divisionList != null,
                  child: AddressListView(
                    onEdit: (Address address) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddress(
                                  divisionList: _divisionList,
                                  address: address)));
                    },
                    onDelete: (String addressID) {
                      _userPresenter.deleteAddress(context, addressID);
                    },
                  ),
                ),
                SizedBox(
                  height: 2 * SizeConfig.heightSizeMultiplier,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 2 * SizeConfig.heightSizeMultiplier,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MyButton(
                      AppLocalization.of(context)
                          .getTranslatedValue("add_address"),
                      marginLeft: 5.12,
                      marginRight: 5.12,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddAddress(divisionList: _divisionList)));
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  void onFailedToGetLocations(
      BuildContext context, String message, int errorType) {
    if (mounted) {
      _showErrorDialog(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("could_not_load_data"));
    }
  }

  @override
  void onLocationsFetched(List<Division> divisions, List<District> districts,
      List<Upazila> upazilas) {
    divisions.forEach((division) {
      division.districtList = List();

      districts.forEach((district) {
        if (division.id == district.divisionID) {
          district.upazilaList = List();

          upazilas.forEach((upazila) {
            if (district.id == upazila.districtID) {
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

  Future<Widget> _showErrorDialog(
      BuildContext mainContext, String subTitle) async {
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
        });
  }

  @override
  void onDisconnected(BuildContext context) {
    if (mounted) {
      _showErrorDialog(context,
          AppLocalization.of(context).getTranslatedValue("not_connected"));
    }
  }

  @override
  void onInactive(BuildContext context) {
    if (mounted) {
      _showErrorDialog(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("inactive_connection"));
    }
  }

  @override
  void onTimeout(BuildContext context) {
    if (mounted) {
      _showErrorDialog(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("connection_time_out"));
    }
  }

  @override
  void onAddressAdded(BuildContext context) {}

  @override
  void onAddressDeleted(BuildContext context, int position) {
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("address_deleted"));

    currentUser.value.addresses.list.removeAt(position);
    currentUser.notifyListeners();

    _sharedPreference.setCurrentUser(currentUser.value);
  }

  @override
  void onAddressUpdated(BuildContext context) {}

  @override
  void onFailed(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  @override
  void onProfileUpdated(BuildContext context, String message) {}
}
