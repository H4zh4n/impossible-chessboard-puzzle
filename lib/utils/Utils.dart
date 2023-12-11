import 'package:url_launcher/url_launcher.dart';

class Utils {
  static launchURL(String url) async {
    if (!url.startsWith("http")) {
      url = "https://" + url;
    }

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
