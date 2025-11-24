import 'package:share_plus/share_plus.dart';

class ShareServices {
  ShareServices._();

  static Future<void> shareUrl(final String url) async {
    await SharePlus.instance.share(ShareParams(text: url));
  }

  static Future<void> shareFile(final XFile file) async {
    SharePlus.instance.share(ShareParams(files: [file]));
  }
}
