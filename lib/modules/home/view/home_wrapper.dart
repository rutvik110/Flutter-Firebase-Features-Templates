import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/modules/home/view/home.dart';

Future<void> handlebgmessage(RemoteMessage event) async {
  print(event.data);
  print(
      'hmm,so this is called if app is in background no matter when user opens the app');
}

class HomeWrapper extends StatefulWidget {
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> with WidgetsBindingObserver {
  Timer? _timerLink;

  Future<void> navigateToView(Uri deepLink) async {
    // String? gameid = deepLink.queryParameters['gameid'];
    // String? gamecode = deepLink.queryParameters['gamecode'];

    // context.read(gamerepositoryprovider).joinGame(gamecode, gameid);
  }

  void handledynamiclink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          final Uri? deepLink = dynamicLink?.link;

          if (deepLink != null) {
            await navigateToView(deepLink);
          }
        },
        onError: (OnLinkErrorException e) async {});

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      await navigateToView(deepLink);
    }
  }

  void handlenotifications(RemoteMessage map) {
    switch (map.data["notification_type"]) {
      case "1":
        // Navigator.pushNamed(context, Routes.TRANSACTIONVIEW,
        //     arguments: map.data['txid']);
        break;
      case "2":
        // Navigator.pushNamed(context, Routes.TRANSACTIONVIEW,
        //     arguments: map.data['txid']);
        break;
      case "3":
        // Get.showSnackbar(GetBar(
        //   message: map.notification?.title,
        //   snackPosition: SnackPosition.TOP,
        //   duration: const Duration(seconds: 3),
        // ));
        break;
      case "4":
        // Get.showSnackbar(
        //   GetBar(
        //     snackPosition: SnackPosition.TOP,
        //     message: 'Reached max points!',
        //     duration: const Duration(seconds: 3),
        //   ),
        // );
        break;

      default:
    }
  }

  void handlemessagesthatopenedtheapp(BuildContext context) async {
    final message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      print('opening form terminated state');
      print(message.data);

      handlenotifications(message);
    }

    FirebaseMessaging.onBackgroundMessage(handlebgmessage);

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print(event.data);

      if (event.data.isNotEmpty) {
        handlenotifications(event);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    handledynamiclink(context);
    handlemessagesthatopenedtheapp(context);
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data);

      if (event.data.isNotEmpty) {
        handlenotifications(event);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _timerLink = new Timer(
        const Duration(milliseconds: 1000),
        () {
          handledynamiclink(context);
          handlemessagesthatopenedtheapp(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}
