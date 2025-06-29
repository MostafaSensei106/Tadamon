import 'package:share_plus/share_plus.dart' show Share;

class ShareServices {
  static void share(String url) {
    Share.share(url);
  }
}
