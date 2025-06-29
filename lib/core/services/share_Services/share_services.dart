import 'package:share_plus/share_plus.dart' show SharePlus, ShareParams;

class ShareServices {
  static void share(String url) {
    SharePlus.instance.share(ShareParams(text: url));
  }
}
