import 'package:url_launcher/url_launcher.dart'
    show launchUrl, LaunchMode, canLaunchUrl;

import '../../widgets/app_toast/app_toast.dart' show AppToast;

class UrlRunServices {
  /// A function to launch a URL.
  ///
  /// It takes a [String] which is the URL to be launched.
  ///
  /// It will try to launch the URL with [LaunchMode.externalApplication].
  ///
  /// If the launch fails, it will throw an [Exception].
  ///
  /// If an [Exception] is thrown, it will show a toast with the error message.
  static Future<void> launchURL(final String url) async {
    try {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  /// A function to send an email.
  ///
  /// It takes a [String] for [toEmail], [subject], and [body].
  ///
  /// It will try to launch the email with [LaunchMode.externalApplication].
  ///
  /// If the launch fails, it will throw an [Exception].
  static Future<void> sendEmail({
    required final String toEmail,
    required final String subject,
    required final String body,
  }) async {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      query:
          '${Uri.encodeQueryComponent('subject')}$subject&${Uri.encodeQueryComponent('body')}=$body',
    );
    if (!await launchUrl(emailLaunchUri)) {
      throw Exception('Could not launch $emailLaunchUri');
    }
  }

  static Future<void> makePhoneCall(final String phoneNumber) async {
    final phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri); // Launch the phone call
    } else {
      throw 'Could not launch phone call';
    }
  }
}
