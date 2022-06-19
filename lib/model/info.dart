import '../model/slider.dart';
import '../utils/api_routes.dart';

class Info {
  String id;
  String name;
  String aboutUs;
  String address;
  String email;
  String facebook;
  String instagram;
  String logo;
  String phone;
  String tagLine;
  String whyUs;
  String invoiceLogo;
  String appVersionCode;
  String appVersionName;
  String appStoreUrl;
  String playStoreUrl;
  String termsConditions;
  String privacyPolicy;
  bool androidUpdateMandatory;
  bool iosUpdateMandatory;
  bool badge;
  bool onlinePaymentActive;
  List<String> agentCodes;
  List<Slider> sliders;
  double deliveryChargeInsideDhaka;
  double deliveryChargeOutsideDhaka;

  Info(
      {this.id,
      this.name,
      this.aboutUs,
      this.address,
      this.email,
      this.facebook,
      this.instagram,
      this.logo,
      this.phone,
      this.tagLine,
      this.whyUs,
      this.invoiceLogo,
      this.badge,
      this.agentCodes,
      this.sliders,
      this.onlinePaymentActive = true,
      this.androidUpdateMandatory,
      this.appStoreUrl,
      this.appVersionCode,
      this.appVersionName,
      this.deliveryChargeInsideDhaka,
      this.deliveryChargeOutsideDhaka,
      this.iosUpdateMandatory,
      this.termsConditions,
      this.privacyPolicy});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['_id'];

    try {
      name = json['name'];
    } catch (error) {}

    try {
      aboutUs = json['aboutUs'];
    } catch (error) {}

    try {
      address = json['address'];
    } catch (error) {}

    try {
      email = json['email'];
    } catch (error) {}

    try {
      facebook = json['facebook'];
    } catch (error) {}

    try {
      instagram = json['instagram'];
    } catch (error) {}

    try {
      logo = APIRoute.BASE_URL + json['logo'];
    } catch (error) {}

    try {
      phone = json['phone'];
    } catch (error) {}

    try {
      tagLine = json['tagLine'];
    } catch (error) {}

    try {
      whyUs = json['whyUs'];
    } catch (error) {}

    try {
      invoiceLogo = APIRoute.BASE_URL + json['invoiceLogo'];
    } catch (error) {}

    try {
      appVersionCode = json['appVersionCode'];
    } catch (error) {}

    try {
      appVersionName = json['appVersionName'];
    } catch (error) {}

    try {
      appStoreUrl = json['appStoreUrl'];
    } catch (error) {}

    try {
      playStoreUrl = json['playStoreUrl'];
    } catch (error) {}

    try {
      termsConditions = json['termsPrivacyAbout']['termsAndCondition'];
    } catch (error) {}

    try {
      privacyPolicy = json['termsPrivacyAbout']['privacyPolicy'];
    } catch (error) {}

    try {
      androidUpdateMandatory = json['androidUpdateMandatory'];
    } catch (error) {}

    try {
      iosUpdateMandatory = json['iosUpdateMandatory'];
    } catch (error) {}

    try {
      badge = json['badge'];
    } catch (error) {}

    try {
      onlinePaymentActive = json['onlinePayment'];
    } catch (error) {}

    try {
      agentCodes = List();

      json['agentCode'].forEach((code) {
        agentCodes.add(code.toString());
      });
    } catch (error) {
      agentCodes = List();
    }

    try {
      sliders = List();

      json['sliders'].forEach((slider) {
        sliders.add(Slider.fromJson(slider));
      });
    } catch (error) {
      sliders = List();
    }

    try {
      deliveryChargeInsideDhaka =
          double.parse(json['deliveryChargeInsideDhaka'].toString());
    } catch (error) {}

    try {
      deliveryChargeOutsideDhaka =
          double.parse(json['deliveryChargeOutsideDhaka'].toString());
    } catch (error) {}
  }
}
