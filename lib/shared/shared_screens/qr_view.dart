import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/utilities/dynamic_link_genearator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExampleState extends StatefulWidget {
  @override
  _QRViewExampleStateState createState() => _QRViewExampleStateState();
}

class _QRViewExampleStateState extends State<QRViewExampleState>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String? result;
  String? link;

  QRViewController? controller;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.resumeCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              overlay: QrScannerOverlayShape(borderWidth: 2),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text('Data: ${result}')
                  : const Text('Scan QR'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      link = scanData.code;
      if (link!.isNotEmpty) {
        controller.dispose();

        final dynamicLinkData = await getDynamicLinkFromLink(link!);

        print(dynamicLinkData!.link);
      }
    }, onDone: () async {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
