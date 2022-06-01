import 'package:url_launcher/url_launcher.dart';
import '../view/home.dart';

class Messaging {

  static Future<void> launchWhatsApp() async {

    var url = "whatsapp://send?phone=+8801925762255";

    if(await canLaunch(url)) {

      await launch(url);
    }
  }

  static Future<void> launchMessenger() async {

    var url = "fb-messenger://m.me/sellmartdotcom";

    if(await canLaunch(url)) {

      await launch(url);
    }
  }

  static Future<void> launchViber() async {

    var url = "viber://pa?chatURI=+8801925762255";

    if(await canLaunch(url)) {

      await launch(url);
    }
  }

  static Future<void> launchImo() async {

    var url = "imo://chat?phone=+8801925762255";

    if(await canLaunch(url)) {

      await launch(url);
    }
  }

  static Future<void> callSupport() async {

    var url = "tel://${info.value.phone ?? ""}";

    if(await canLaunch(url)) {

      await launch(url);
    }
  }
}