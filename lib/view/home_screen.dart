import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/getEventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var _selectedTab = _SelectedTab.home;
  // ignore: unused_field
  int? _selectedDropdownIndex;

  EventViewModel eventViewModel = EventViewModel();
  String? selectedType;
  List<String>? eventNames;

  @override
  void initState() {
    eventViewModel.eventApi(context).then((names) {
      setState(() {
        eventNames = names;
        if (eventNames != null && eventNames!.isNotEmpty) {
          selectedType = eventNames![0];
        }
      });
    });
    super.initState();
  }

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  void _onQRCodePressed() {
    Navigator.pushNamed(context, RouteNames.scanner);
  }

  @override
  Widget build(BuildContext context) {
    eventViewModel = Provider.of<EventViewModel>(context);
    // String json = jsonEncode(eventViewModel.eventsList.data);
    // debugPrint("RESPONSE ${jsonDecode(json)}");

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Utils.appBar(
        'amFOSS Attendence Tracker',
        automaticallyImplyLeading: false,
      ),
      extendBody: true,
      body: Container(
        color: ColorsClass.lightBlack,
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 120,
                ),
                Text("Events",
                    style: GoogleFonts.oxygen(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: ColorsClass.white)),
                const SizedBox(
                  width: double.infinity,
                  height: 50,
                ),
                SizedBox(
                  width: 200,
                  child: DropdownButtonFormField<String>(
                    isExpanded: false,
                    hint: Text('Select Event',
                        style: GoogleFonts.oxygen(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: ColorsClass.white)),
                    decoration: InputDecoration(
                        fillColor: ColorsClass.amber,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                                color: ColorsClass.amber, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40))),
                    disabledHint: Text('Select Event',
                        style: GoogleFonts.oxygen(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: ColorsClass.white)),
                    dropdownColor: ColorsClass.amber,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    iconDisabledColor: Colors.blue,
                    iconEnabledColor: ColorsClass.white,
                    value: selectedType,
                    items: eventNames?.map((name) {
                      return DropdownMenuItem<String>(
                        value: name,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Text(name,
                              style: GoogleFonts.oxygen(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsClass.white)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                )
              ],
            ),
            const Positioned(
              top: 500,
              left: 174,
              child: Text('count'),
            ),
            // Positioned(
            //     top: 650,
            //     right: 20,
            //     child: SizedBox(
            //       width: 70,
            //       height: 70,
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(80)),
            //             backgroundColor: ColorsClass.amber),
            //         onPressed: () async {
            //           final SharedPreferences sharedPreferences =
            //               await SharedPreferences.getInstance();
            //           sharedPreferences.remove('token');
            //           debugPrint(sharedPreferences.getString('refresh'));

            //           //get the refresh token

            //           //make a request to the refresh end point
            //           //store the token I get
            //         },
            //         child: const Icon(Icons.refresh),
            //       ),
            //     ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarUtils(
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        onTabTapped: _handleIndexChanged,
        onQRCodePressed: _onQRCodePressed,
      ),
    );
  }
}

enum _SelectedTab { home, qrCode, details }
