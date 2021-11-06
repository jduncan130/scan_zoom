import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class ScanView extends StatefulWidget {
  const ScanView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  var qrText = '';
  var flashState = flashOn;
  var cameraState = frontCamera;
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iAttended'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              //openAccountScreen(context);
              if (controller != null) {
                controller.toggleFlash();
                if (_isFlashOn(flashState)) {
                  setState(() {
                    flashState = flashOff;
                  });
                } else {
                  setState(() {
                    flashState = flashOn;
                  });
                }
              }
            },
            icon: Icon(Icons.flash_on_rounded),
          ),
        ],
        //bottom: _tabBar,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isFlashOn(String current) {
    return flashOn == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      controller.dispose();
      Navigator.of(context).pop(scanData.code);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
