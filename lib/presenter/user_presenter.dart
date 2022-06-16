import 'dart:convert';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import '../contract/login_contract.dart';
import '../contract/password_contract.dart';
import '../contract/profile_contract.dart';
import '../model/address.dart';
import '../contract/connectivity_contract.dart';
import '../contract/otp_contract.dart';
import '../contract/register_contract.dart';
import '../localization/app_localization.dart';
import '../model/user.dart';
import '../utils/api_routes.dart';
import '../utils/constants.dart';
import '../utils/custom_log.dart';
import '../utils/custom_trace.dart';
import '../utils/my_overlay_loader.dart';
import '../utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart' as con;

ValueNotifier<User> currentUser = ValueNotifier(User());

class UserPresenter with ChangeNotifier {
  Connectivity _connectivity;
  OTPContract _otpContract;
  RegisterContract _registerContract;
  LoginContract _loginContract;
  PasswordContract _passwordContract;
  ProfileContract _profileContract;

  MySharedPreference _sharedPreference = MySharedPreference();

  AddressCheckOptions _options = AddressCheckOptions(InternetAddress("8.8.8.8"),
      port: 53, timeout: Duration(seconds: 2));

  MyOverlayLoader _myOverlayLoader = MyOverlayLoader();

  UserPresenter(Connectivity connectivity,
      {OTPContract otpContract,
      RegisterContract registerContract,
      LoginContract loginContract,
      PasswordContract passwordContract,
      ProfileContract profileContract}) {
    this._connectivity = connectivity;

    if (otpContract != null) {
      this._otpContract = otpContract;
    }

    if (registerContract != null) {
      this._registerContract = registerContract;
    }

    if (loginContract != null) {
      this._loginContract = loginContract;
    }

    if (passwordContract != null) {
      this._passwordContract = passwordContract;
    }

    if (profileContract != null) {
      this._profileContract = profileContract;
    }
  }

  Future<void> hideOverlayLoader() async {
    try {
      if (_myOverlayLoader != null && _myOverlayLoader.loader != null) {
        _myOverlayLoader.loader.remove();
      }
    } catch (error) {}
  }

  void sendSignUpOTP(BuildContext context, User user) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            Map<String, dynamic> data = {
              'phone': user.phone,
              'firstName': user.firstName,
              'lastName': user.lastName
            };

            if (user.referralCode != null && user.referralCode.isNotEmpty) {
              data['anotherReferCode'] = user.referralCode;
            }

            client
                .post(
              Uri.encodeFull(APIRoute.SEND_SIGNUP_OTP),
              headers: {"Accept": "application/json"},
              body: data,
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Send SignUp OTP",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _otpContract.onOTPSent(user.phone);
                } else {
                  if (jsonData['message'] == Constants.Phone_Already_Used) {
                    _otpContract.onFailedToSendOTP(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("phone_number_taken"));
                  }
                  if (jsonData['message'] == Constants.INVALID_REFERRAL_CODE) {
                    _otpContract.onFailedToSendOTP(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("invalid_referral_code"));
                  } else {
                    _otpContract.onFailedToSendOTP(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("failed_to_send_otp"));
                  }
                }
              } else {
                if (!jsonData['success']) {
                  if (jsonData['message'] == Constants.Phone_Already_Used) {
                    _otpContract.onFailedToSendOTP(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("phone_number_taken"));
                  }
                  if (jsonData['message'] == Constants.INVALID_REFERRAL_CODE) {
                    _otpContract.onFailedToSendOTP(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("invalid_referral_code"));
                  } else {
                    _otpContract.onFailedToSendOTP(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("failed_to_send_otp"));
                  }
                }
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _otpContract.onFailedToSendOTP(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_send_otp"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void signUp(BuildContext context, User user) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            client
                .post(
              Uri.encodeFull(APIRoute.SIGNUP),
              headers: {"Accept": "application/json"},
              body: user.toSignUpSecondStep(),
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "SignUp",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _setUser(jsonData, jsonData['token'].toString());
                  _registerContract.onSuccess();
                }
              } else {
                if (!jsonData['success']) {
                  if (jsonData['message'] == Constants.INVALID_OTP) {
                    _registerContract.onFailure(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("invalid_otp"));
                  } else {
                    _registerContract.onFailure(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("failed_to_register"));
                  }
                }
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _registerContract.onFailure(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_register"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void login(BuildContext context, User user) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            client
                .post(
              Uri.encodeFull(APIRoute.SIGNIN),
              headers: {"Accept": "application/json"},
              body: user.toLogin(),
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Login",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _setUser(jsonData, jsonData['token'].toString());
                  _loginContract.onSuccess();
                }
              } else {
                if (!jsonData['success']) {
                  if (jsonData['message'] == Constants.INCORRECT_PHONE) {
                    _loginContract.onFailure(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("incorrect_phone"));
                  } else if (jsonData['message'] == Constants.WRONG_PASSWORD) {
                    _loginContract.onFailure(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("incorrect_password"));
                  } else if (jsonData['message'] ==
                      Constants.INCORRECT_PHONE_OR_PASSWORD) {
                    _loginContract.onFailure(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("phone_or_password_incorrect"));
                  } else {
                    _loginContract.onFailure(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("failed_to_login"));
                  }
                }
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _loginContract.onFailure(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_login"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void sendPasswordResetOTP(BuildContext context, String phone) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            Map<String, dynamic> data = {
              'phone': phone,
            };

            client
                .post(
              Uri.encodeFull(APIRoute.FORGOT_PASSWORD),
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
              },
              body: jsonEncode(data),
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Forgot Password",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _otpContract.onOTPSent(phone);
                }
              } else {
                if (!jsonData['success']) {
                  if (jsonData['message'] == Constants.NUMBER_NOT_FOUND) {
                    _otpContract.onFailedToSendOTP(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("phone_not_found"));
                  } else {
                    _otpContract.onFailedToSendOTP(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("failed_to_verify_number"));
                  }
                }
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _otpContract.onFailedToSendOTP(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_verify_number"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void resetPassword(BuildContext context, User user) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            client
                .post(
              Uri.encodeFull(APIRoute.RESET_PASSWORD),
              headers: {"Accept": "application/json"},
              body: user.toJson(),
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Reset Password",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _passwordContract.onSuccess();
                }
              } else {
                if (!jsonData['success']) {
                  if (jsonData['message'] == Constants.INVALID_OTP) {
                    _passwordContract.onFailure(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("invalid_otp"));
                  } else {
                    _passwordContract.onFailure(
                        context,
                        AppLocalization.of(context)
                            .getTranslatedValue("failed_to_reset_password"));
                  }
                }
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _passwordContract.onFailure(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_reset_password"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void updateProfileImage(BuildContext context, String imgBase64) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            Map<String, dynamic> data = {"image": imgBase64};

            client
                .post(
              Uri.encodeFull(
                  APIRoute.UPDATE_PROFILE_IMAGE + currentUser.value.id),
              headers: {"Accept": "application/json"},
              body: data,
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Update Profile Image",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _setUser(jsonData, currentUser.value.token);
                  _profileContract.onProfileUpdated(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("profile_image_updated"));
                }
              } else {
                _profileContract.onFailed(
                    context,
                    AppLocalization.of(context)
                        .getTranslatedValue("failed_to_update_profile_image"));
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _profileContract.onFailed(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_update_profile_image"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void updatePersonalInfo(BuildContext context, User user) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            Map<String, dynamic> data = {
              "firstName": user.firstName,
              "lastName": user.lastName
            };

            if (user.phone != null &&
                user.phone.isNotEmpty &&
                user.phone != currentUser.value.phone) {
              data['phone'] = user.phone;
            }

            if (user.email != null && user.email.isNotEmpty) {
              data['email'] = user.email;
            }

            client
                .put(
              Uri.encodeFull(APIRoute.CUSTOMER_UPDATE + currentUser.value.id),
              headers: {
                "Authorization": "Bearer " + currentUser.value.token,
                "Accept": "application/json"
              },
              body: data,
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Update Personal Info",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _setUser(jsonData, currentUser.value.token);
                  _profileContract.onProfileUpdated(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("personal_info_updated"));
                }
              } else {
                if (jsonData['message'] == Constants.Phone_Already_Used) {
                  _profileContract.onFailed(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("phone_number_taken"));
                } else {
                  _profileContract.onFailed(
                      context,
                      AppLocalization.of(context).getTranslatedValue(
                          "failed_to_update_personal_info"));
                }
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _profileContract.onFailed(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_update_personal_info"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void addNewAddress(BuildContext context, Address address) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            Map<String, dynamic> data = {"address": address.toAddUpdate()};

            client
                .post(
              Uri.encodeFull(APIRoute.ADDRESS_ADD + currentUser.value.id),
              headers: {
                "Authorization": "Bearer " + currentUser.value.token,
                "Accept": "application/json",
                "Content-Type": "application/json"
              },
              body: jsonEncode(data),
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Add New Address",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _setUser(jsonData, currentUser.value.token);
                  _profileContract.onAddressAdded(context);
                }
              } else {
                _profileContract.onFailed(
                    context,
                    AppLocalization.of(context)
                        .getTranslatedValue("failed_to_add_address"));
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _profileContract.onFailed(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_add_address"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void updateAddress(BuildContext context, Address address) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            Map<String, dynamic> data = {"address": address.toAddUpdate()};

            client
                .post(
              Uri.encodeFull(APIRoute.ADDRESS_UPDATE +
                  currentUser.value.id +
                  "/" +
                  address.id),
              headers: {
                "Authorization": "Bearer " + currentUser.value.token,
                "Accept": "application/json",
                "Content-Type": "application/json"
              },
              body: jsonEncode(data),
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Address Update",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 || response.statusCode == 201) {
                if (jsonData['success']) {
                  _setUser(jsonData, currentUser.value.token);
                  _profileContract.onAddressUpdated(context);
                }
              } else {
                _profileContract.onFailed(
                    context,
                    AppLocalization.of(context)
                        .getTranslatedValue("failed_to_update_address"));
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _profileContract.onFailed(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_update_address"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void deleteAddress(BuildContext context, String addressID) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            client.delete(Uri.encodeFull(APIRoute.ADDRESS_DELETE + addressID),
                headers: {
                  "Authorization": "Bearer " + currentUser.value.token,
                  "Accept": "application/json"
                }).then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Address Delete",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 ||
                  response.statusCode == 201 ||
                  response.statusCode == 202) {
                if (jsonData['success']) {
                  for (int i = 0;
                      i < currentUser.value.addresses.list.length;
                      i++) {
                    if (currentUser.value.addresses.list[i].id == addressID) {
                      _profileContract.onAddressDeleted(context, i);
                      break;
                    }
                  }
                } else {
                  _profileContract.onFailed(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("failed_to_delete_address"));
                }
              } else {
                _profileContract.onFailed(
                    context,
                    AppLocalization.of(context)
                        .getTranslatedValue("failed_to_delete_address"));
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _profileContract.onFailed(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("failed_to_delete_address"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void changePassword(BuildContext context, User user) {
    con.Connectivity().checkConnectivity().then((result) {
      if (result == con.ConnectivityResult.mobile ||
          result == con.ConnectivityResult.wifi) {
        DataConnectionChecker().isHostReachable(_options).then((addressCheck) {
          if (addressCheck.isSuccess) {
            _myOverlayLoader.customLoaderWithBlurEffect(context);

            var client = http.Client();

            client
                .post(
              Uri.encodeFull(APIRoute.CHANGE_PASSWORD + currentUser.value.id),
              headers: {
                "Authorization": "Bearer " + currentUser.value.token,
                "Accept": "application/json"
              },
              body: user.changePassword(),
            )
                .then((response) async {
              CustomLogger.debug(
                  trace: CustomTrace(StackTrace.current),
                  tag: "Change Password",
                  message: response.body);

              var jsonData = json.decode(response.body);

              _myOverlayLoader.dismissDialog(context);

              if (response.statusCode == 200 ||
                  response.statusCode == 201 ||
                  response.statusCode == 202) {
                if (jsonData['success']) {
                  _profileContract.onProfileUpdated(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("password_changed"));
                }
              } else {
                if (jsonData['message'] == Constants.OLD_PASSWORD_WRONG) {
                  _profileContract.onFailed(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("old_pass_wrong"));
                } else {
                  _profileContract.onFailed(
                      context,
                      AppLocalization.of(context)
                          .getTranslatedValue("password_changed_failed"));
                }
              }
            }).timeout(Duration(seconds: Constants.timeoutSeconds),
                    onTimeout: () {
              client.close();

              _myOverlayLoader.dismissDialog(context);
              _connectivity.onTimeout(context);
            }).catchError((error) {
              print(error);

              _myOverlayLoader.dismissDialog(context);
              _profileContract.onFailed(
                  context,
                  AppLocalization.of(context)
                      .getTranslatedValue("password_changed_failed"));
            });
          } else {
            _connectivity.onInactive(context);
          }
        });
      } else {
        _connectivity.onDisconnected(context);
      }
    });
  }

  void _setUser(var jsonData, String token) {
    currentUser.value = User.fromJson(jsonData['data']);

    currentUser.value.addresses.list.insert(0, Address());

    currentUser.value.token = token;
    print("token: " + currentUser.value.token);
    print("ID: " + currentUser.value.id);
    currentUser.notifyListeners();

    _sharedPreference.setCurrentUser(currentUser.value);
  }
}
