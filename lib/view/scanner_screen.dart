import 'package:attendencetracker/utlities/utils.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class QRScanner extends StatefulWidget {
  final VoidCallback onQRCodePressed;

  const QRScanner({Key? key, required this.onQRCodePressed}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  ScanResult? scanResult;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');

  final _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  final _selectedCamera = -1;
  final _useAutoFocus = true;
  final _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
      _scan();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scanResult = this.scanResult;
    return Scaffold(
      appBar: Utils.appBar(
        'QR Scanner',
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          if (scanResult != null)
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Result Type'),
                    subtitle: Text(scanResult.type.toString()),
                  ),
                  ListTile(
                    title: const Text('Raw Content'),
                    subtitle: Text(scanResult.rawContent),
                  ),
                  ListTile(
                    title: const Text('Format'),
                    subtitle: Text(scanResult.format.toString()),
                  ),
                  ListTile(
                    title: const Text('Format note'),
                    subtitle: Text(scanResult.formatNote),
                  ),
                ],
              ),
            ),
          // Rest of your UI elements...
        ],
      ),
    );
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }
}

