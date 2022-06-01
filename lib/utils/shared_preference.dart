import 'dart:convert';

import '../model/user.dart';

import '../localization/localization_constrants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {

  Future<SharedPreferences> _prefs;

  static const String LANGUAGE_CODE = "nw35949t584";
  static const String CURRENT_USER = "cb45349554u";

  MySharedPreference() {
    _prefs = SharedPreferences.getInstance();
  }


  Future<Locale> saveLanguageCode(String languageCode) async {

    final SharedPreferences prefs = await _prefs;
    await prefs.setString(LANGUAGE_CODE, languageCode);

    return getLocale(languageCode);
  }


  Future<Locale> getLanguageCode() async {

    final SharedPreferences prefs = await _prefs;
    String languageCode = prefs.getString(LANGUAGE_CODE) ?? ENGLISH;

    return getLocale(languageCode);
  }


  Future<void> setCurrentUser(User user) async {

    final SharedPreferences prefs = await _prefs;
    await prefs.setString(CURRENT_USER, json.encode(user.toJson()));
  }


  Future<User> getCurrentUser() async {

    final SharedPreferences prefs = await _prefs;
    User user = User();

    if(prefs.containsKey(CURRENT_USER)) {

      var data = json.decode(await prefs.get(CURRENT_USER));
      user = User.fromJson(data);
    }

    return user;
  }


  Future<Set<String>> getAllKeys() async {

    final SharedPreferences prefs = await _prefs;
    return prefs.getKeys();
  }


  Future<bool> clearAllData() async {

    final SharedPreferences prefs = await _prefs;
    return prefs.clear();
  }


  Future remove(String key) async {

    final SharedPreferences prefs = await _prefs;

    if(prefs.containsKey(key)) {
      await prefs.remove(key);
    }
  }
}