// ignore_for_file: unused_field, unused_local_variable

import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/resources/components/round_button.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String? selectedValue;

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
    final List<String> items = ["1", "2"];

    final scanAttendeeModel = Provider.of<ScanAttendeeModel>(context);

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
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          color: ColorsClass.lightBlack,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
                height: 120,
              ),
              SizedBox(
                child: ListTile(
                  title: Align(
                    alignment: Alignment.center,
                    child: Text('Scanned ID',
                        style: GoogleFonts.oxygen(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: ColorsClass.white)),
                  ),
                  subtitle: Center(
                    child: Text(
                      '${scanResult?.rawContent}',
                      style: GoogleFonts.oxygen(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: ColorsClass.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 90,
              ),
              Center(
                child: SizedBox(
                  child: Text(
                    'Select Session',
                    style: GoogleFonts.oxygen(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: ColorsClass.white),
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    hint: Row(
                      children: [
                        const Icon(
                          Icons.arrow_downward_sharp,
                          size: 16,
                          color: ColorsClass.amber,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                            child: Text(
                          'Select Session',
                          style: GoogleFonts.oxygen(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ColorsClass.white),
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                    items: items
                        .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              child: Text(
                                item,
                                style: GoogleFonts.oxygen(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsClass.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: 160,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: ColorsClass.transparent,
                        ),
                        color: ColorsClass.amber,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.yellow,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorsClass.amber,
                      ),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 50,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 70,
              ),
              SizedBox(
                child: SizedBox(
                  width: 180,
                  height: 45,
                  child: RoundButton(
                      buttonName: 'Submit',
                      onPressed: () {
                        Map data = {
                          "id": scanResult?.rawContent,
                          "date": "10/12/2023",
                          "session": selectedValue.toString(),
                          "time": formatedTime.toString()
                        };
                        scanAttendeeModel.scanAttendee(data, context);
                      }),
                ),
              )
            ],
          ),
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
