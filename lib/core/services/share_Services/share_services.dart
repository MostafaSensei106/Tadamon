import 'package:share_plus/share_plus.dart' show SharePlus, ShareParams;

class ShareServices {
  static void share(final String url) {
    SharePlus.instance.share(ShareParams(text: url));
  }
}
