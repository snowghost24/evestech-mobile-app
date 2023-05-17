import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers with ChangeNotifier {

  void launchURL(url) async {
    // final url = Constants.privacyPolicy['url'] as String;
    //names
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  
}
