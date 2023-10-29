// ignore_for_file: unused_field

import 'package:attendencetracker/utlities/utils.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utlities/routes/route_names.dart';
import '../view_model/scanAttendeeModel.dart';

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
    final scanAttendeeModel = Provider.of<ScanAttendeeModel>(context);

    final TextEditingController sessionController = TextEditingController();

    DateTime dateTime = DateTime.now();

    String formatedTime = DateFormat("kk:mm").format(dateTime);
    String formatedDate = DateFormat("dd/MM/yyyy").format(dateTime);

    final scanResult = this.scanResult; //returns the data from QR code
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(
            context, RouteNames.home); // Navigate back to the home page
        return true;
      },
      child: Scaffold(
        appBar: Utils.appBar('QR Scanner', automaticallyImplyLeading: true),
        body: Stack(
          children: <Widget>[
            if (scanResult != null)
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Raw Content'),
                      subtitle: Text(scanResult.rawContent),
                    ),
                    ListTile(
                      title: const Text('Format'),
                      subtitle: Text(scanResult.runtimeType.toString()),
                    ),
                  ],
                ),
              ),
            Positioned(
              top: 150, // Adjust the top position for the TextField
              left: 20,
              child: SizedBox(
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Enter the session number',
                  ),
                  controller: sessionController,
                ),
              ),
            ),
            Positioned(
              top: 250, // Adjust the top position for the ElevatedButton
              left: 115,
              child: ElevatedButton(
                onPressed: () {
                  Map data = {
                    "id": scanResult?.rawContent,
                    "date": "10/12/2023",
                    "session": sessionController.text,
                    "time": formatedTime
                  };
                  scanAttendeeModel.scanAttendee(data, context);
                },
                child: const Text('Mark Attendance'),
              ),
            ),
          ],
        ),
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
