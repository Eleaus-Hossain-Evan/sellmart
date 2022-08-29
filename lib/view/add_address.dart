import 'package:app/view/cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widget/my_button.dart';

import '../utils/my_flush_bar.dart';

import '../contract/connectivity_contract.dart';
import '../contract/profile_contract.dart';
import '../localization/app_localization.dart';
import '../model/address.dart';
import '../model/district.dart';
import '../model/division.dart';
import '../model/upazilla.dart';
import '../presenter/user_presenter.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget {
  final List<Division> divisionList;
  final Address address;

  AddAddress({this.address, this.divisionList});

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress>
    with ChangeNotifier
    implements Connectivity, ProfileContract {
  UserPresenter _userPresenter;

  Connectivity _connectivity;
  ProfileContract _profileContract;

  List<Division> _divisions = List();
  List<District> _districts = List();
  List<Upazila> _upazilas = List();

  String _divisionID;
  String _districtID;
  String _upazilaID;

  String _divisionName;
  String _districtName;
  String _upazilaName;

  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    _divisions = widget.divisionList;
    _init();

    _connectivity = this;
    _profileContract = this;

    _userPresenter =
        UserPresenter(_connectivity, profileContract: _profileContract);

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
                  MyAppBar(
                    widget.address == null
                        ? AppLocalization.of(context)
                            .getTranslatedValue("add_address")
                        : AppLocalization.of(context)
                            .getTranslatedValue("update_address"),
                    onBackPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 5.12 * SizeConfig.widthSizeMultiplier,
                        right: 5.12 * SizeConfig.widthSizeMultiplier,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overScroll) {
                          overScroll.disallowGlow();
                          return;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 5 * SizeConfig.heightSizeMultiplier,
                              ),
                              Container(
                                height: 6 * SizeConfig.heightSizeMultiplier,
                                child: TextField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context).textTheme.subtitle2,
                                  decoration: InputDecoration(
                                    hintText: AppLocalization.of(context)
                                        .getTranslatedValue("name"),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[500],
                                        ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .3 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                        width: .051 *
                                            SizeConfig.widthSizeMultiplier,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .3 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                        width: .051 *
                                            SizeConfig.widthSizeMultiplier,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .3 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                        width: .051 *
                                            SizeConfig.widthSizeMultiplier,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(
                                        1.5 * SizeConfig.heightSizeMultiplier),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3.25 * SizeConfig.heightSizeMultiplier,
                              ),
                              Container(
                                height: 6 * SizeConfig.heightSizeMultiplier,
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context).textTheme.subtitle2,
                                  decoration: InputDecoration(
                                    hintText: AppLocalization.of(context)
                                        .getTranslatedValue("mobile"),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[500],
                                        ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .3 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                        width: .051 *
                                            SizeConfig.widthSizeMultiplier,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .3 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                        width: .051 *
                                            SizeConfig.widthSizeMultiplier,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          .3 * SizeConfig.heightSizeMultiplier),
                                      borderSide: BorderSide(
                                        width: .051 *
                                            SizeConfig.widthSizeMultiplier,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(
                                        1.5 * SizeConfig.heightSizeMultiplier),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.5 * SizeConfig.heightSizeMultiplier,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        .769 * SizeConfig.widthSizeMultiplier),
                                child: Text(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("division"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                        color: Colors.black.withOpacity(.75),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 1.25 * SizeConfig.heightSizeMultiplier,
                              ),
                              DropdownButtonFormField(
                                value: _divisionID,
                                isExpanded: true,
                                isDense: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(
                                      1.25 * SizeConfig.heightSizeMultiplier),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _divisionID = value;
                                  });

                                  _onDivisionSelected();
                                },
                                items: _divisions.map((division) {
                                  return DropdownMenuItem(
                                      child: Text(division.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2),
                                      value: division.id);
                                }).toList(),
                              ),
                              SizedBox(
                                height: 2.5 * SizeConfig.heightSizeMultiplier,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        .769 * SizeConfig.widthSizeMultiplier),
                                child: Text(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("district"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                        color: Colors.black.withOpacity(.75),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 1.25 * SizeConfig.heightSizeMultiplier,
                              ),
                              DropdownButtonFormField(
                                value: _districtID,
                                isExpanded: true,
                                isDense: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(
                                      1.25 * SizeConfig.heightSizeMultiplier),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (_districts.length == 0) {
                                    _showToast(
                                        AppLocalization.of(context)
                                            .getTranslatedValue(
                                                "select_division"),
                                        Toast.LENGTH_SHORT);
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _districtID = value;
                                  });

                                  _onDistrictSelected();
                                },
                                items: _districts.map((district) {
                                  return DropdownMenuItem(
                                      child: Text(district.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2),
                                      value: district.id);
                                }).toList(),
                              ),
                              SizedBox(
                                height: 2.5 * SizeConfig.heightSizeMultiplier,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        .769 * SizeConfig.widthSizeMultiplier),
                                child: Text(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("upazila"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                        color: Colors.black.withOpacity(.75),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 1.25 * SizeConfig.heightSizeMultiplier,
                              ),
                              DropdownButtonFormField(
                                value: _upazilaID,
                                isExpanded: true,
                                isDense: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(
                                      1.25 * SizeConfig.heightSizeMultiplier),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (_upazilas.length == 0) {
                                    _showToast(
                                        AppLocalization.of(context)
                                            .getTranslatedValue(
                                                "select_district"),
                                        Toast.LENGTH_SHORT);
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _upazilaID = value;
                                  });

                                  _onUpazilaSelected();
                                },
                                items: _upazilas.map((upazila) {
                                  return DropdownMenuItem(
                                      child: Text(upazila.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2),
                                      value: upazila.id);
                                }).toList(),
                              ),
                              SizedBox(
                                height: 2.5 * SizeConfig.heightSizeMultiplier,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        .769 * SizeConfig.widthSizeMultiplier),
                                child: Text(
                                  AppLocalization.of(context)
                                      .getTranslatedValue("address"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                        color: Colors.black.withOpacity(.75),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 1.25 * SizeConfig.heightSizeMultiplier,
                              ),
                              TextField(
                                controller: _addressController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: Theme.of(context).textTheme.subtitle2,
                                onSubmitted: (string) {
                                  FocusScope.of(context).unfocus();
                                },
                                decoration: InputDecoration(
                                  hintText: AppLocalization.of(context)
                                      .getTranslatedValue("enter_rd_sector"),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey[500],
                                      ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        .3 * SizeConfig.heightSizeMultiplier),
                                    borderSide: BorderSide(
                                      width:
                                          .051 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(
                                      1.6875 * SizeConfig.heightSizeMultiplier),
                                ),
                              ),
                              SizedBox(
                                height: 8 * SizeConfig.heightSizeMultiplier,
                              ),
                              MyButton(
                                AppLocalization.of(context)
                                    .getTranslatedValue("save_address"),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  order.value.address = Address.init();
                                  _validate(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
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

  void _init() {
    if (widget.address != null &&
        widget.address.id != null &&
        widget.address.id.isNotEmpty) {
      _nameController.text = widget.address.name ?? "";
      _phoneController.text = widget.address.phone ?? "";

      for (int i = 0; i < _divisions.length; i++) {
        if (_divisions[i].name == widget.address.division ||
            _divisions[i].bnName == widget.address.division) {
          _divisionID = _divisions[i].id;
          _divisionName = widget.address.division;

          for (int j = 0; j < _divisions[i].districtList.length; j++) {
            if (_divisions[i].districtList[j].name == widget.address.district ||
                _divisions[i].districtList[j].bnName ==
                    widget.address.district) {
              _districtID = _divisions[i].districtList[j].id;
              _districtName = widget.address.district;

              for (int k = 0;
                  k < _divisions[i].districtList[j].upazilaList.length;
                  k++) {
                if (_divisions[i].districtList[j].upazilaList[k].name ==
                        widget.address.upazila ||
                    _divisions[i].districtList[j].upazilaList[k].bnName ==
                        widget.address.upazila) {
                  _upazilaID = _divisions[i].districtList[j].upazilaList[k].id;
                  _upazilaName = widget.address.upazila;

                  _upazilas.clear();
                  _upazilas.addAll(_divisions[i].districtList[j].upazilaList);

                  break;
                }
              }

              _districts.clear();
              _districts.addAll(_divisions[i].districtList);

              break;
            }
          }
        }
      }

      _addressController.text = widget.address.details ?? "";
    }
  }

  Future<bool> _onBackPress() {
    Navigator.pop(context);
    return Future(() => false);
  }

  @override
  void dispose() {
    _userPresenter.hideOverlayLoader();
    super.dispose();
  }

  @override
  void onDisconnected(BuildContext context) {
    if (mounted) {
      MyFlushBar.show(context,
          AppLocalization.of(context).getTranslatedValue("not_connected"));
    }
  }

  @override
  void onInactive(BuildContext context) {
    if (mounted) {
      MyFlushBar.show(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("inactive_connection"));
    }
  }

  @override
  void onTimeout(BuildContext context) {
    if (mounted) {
      MyFlushBar.show(
          context,
          AppLocalization.of(context)
              .getTranslatedValue("connection_time_out"));
    }
  }

  @override
  void onFailed(BuildContext context, String message) {
    MyFlushBar.show(context, message);
  }

  @override
  void onProfileUpdated(BuildContext context, String message) {}

  @override
  void onAddressAdded(BuildContext context) {
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("address_added"));
  }

  @override
  void onAddressDeleted(BuildContext context, int position) {}

  @override
  void onAddressUpdated(BuildContext context) {
    MyFlushBar.show(context,
        AppLocalization.of(context).getTranslatedValue("address_updated"));
    Navigator.pop(context);
  }

  void _showToast(String message, Toast length) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(.8),
      textColor: Colors.white,
      fontSize: 2 * SizeConfig.textSizeMultiplier,
    );
  }

  void _onDivisionSelected() {
    setState(() {
      _districtID = null;
      _upazilaID = null;
      _districts = List();
      _upazilas = List();
    });

    for (int i = 0; i < _divisions.length; i++) {
      if (_divisions[i].id == _divisionID) {
        _divisionName = _divisions[i].name;

        setState(() {
          _districts.clear();
          _districts.addAll(_divisions[i].districtList);
        });

        break;
      }
    }
  }

  void _onDistrictSelected() {
    setState(() {
      _upazilaID = null;
      _upazilas = List();
    });

    for (int i = 0; i < _districts.length; i++) {
      if (_districts[i].id == _districtID) {
        _districtName = _districts[i].name;

        setState(() {
          _upazilas.clear();
          _upazilas.addAll(_districts[i].upazilaList);
        });

        break;
      }
    }
  }

  void _onUpazilaSelected() {
    for (int i = 0; i < _upazilas.length; i++) {
      if (_upazilas[i].id == _upazilaID) {
        _upazilaName = _upazilas[i].name;
        break;
      }
    }
  }

  void _validate(BuildContext context) {
    if (_nameController.text.isEmpty) {
      _showToast(AppLocalization.of(context).getTranslatedValue("enter_name"),
          Toast.LENGTH_SHORT);
    } else {
      if (_phoneController.text.isEmpty) {
        _showToast(
            AppLocalization.of(context).getTranslatedValue("enter_phone"),
            Toast.LENGTH_SHORT);
      } else {
        if (_phoneController.text.length != 11) {
          _showToast(
              AppLocalization.of(context)
                  .getTranslatedValue("must_be_11_digits"),
              Toast.LENGTH_SHORT);
        } else {
          if (_divisionID == null || _divisionID.isEmpty) {
            _showToast(
                AppLocalization.of(context)
                    .getTranslatedValue("select_division"),
                Toast.LENGTH_SHORT);
          } else {
            if (_districtID == null || _districtID.isEmpty) {
              _showToast(
                  AppLocalization.of(context)
                      .getTranslatedValue("select_district"),
                  Toast.LENGTH_SHORT);
            } else {
              if (_upazilaID == null || _upazilaID.isEmpty) {
                _showToast(
                    AppLocalization.of(context)
                        .getTranslatedValue("select_upazila"),
                    Toast.LENGTH_SHORT);
              } else {
                if (_addressController.text.isEmpty) {
                  _showToast(
                      AppLocalization.of(context)
                          .getTranslatedValue("enter_rd_block"),
                      Toast.LENGTH_SHORT);
                } else {
                  Address address = Address(
                      name: _nameController.text,
                      phone: _phoneController.text,
                      division: _divisionName,
                      district: _districtName,
                      upazila: _upazilaName,
                      details: _addressController.text);

                  if (widget.address != null &&
                      widget.address.id != null &&
                      widget.address.id.isNotEmpty) {
                    address.id = widget.address.id;
                    _userPresenter.updateAddress(context, address);
                    // Future.delayed(Duration(milliseconds: 1000), () {
                    //   Navigator.pop(context);
                    // });
                  } else {
                    _userPresenter.addNewAddress(context, address);
                    Navigator.pop(context);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
