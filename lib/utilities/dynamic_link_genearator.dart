import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<String> createDynamicLink(String recordId) async {
  // final chatroomid = user.user.uid;

  //Dynamic link generalization
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://flutterfirebasefeaturetemplates.page.link',
    //alertroomid=${alertroomid}&
    link:
        Uri.parse('https://flutterfirebase.com/recordroom?recordId=$recordId'),
    iosParameters: IosParameters(
      minimumVersion: '0',
      bundleId: 'com.example.flutter_firebase_template',
    ),
    androidParameters: AndroidParameters(
      packageName: 'com.example.flutter_firebase_template',
      minimumVersion: 0,
    ),
  );

  final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();

  final Uri shortUrl = shortDynamicLink.shortUrl;

  return shortUrl.toString();
}
