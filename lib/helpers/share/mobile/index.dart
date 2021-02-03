import 'package:share/share.dart';

void shareInputText({
  required String inputText,
  required String subject,
}) {
  Share.share(
    inputText,
    subject: subject,
  );
}
