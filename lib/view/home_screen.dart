// ignore_for_file: unused_field

import 'package:attendencetracker/model/getAttendees_model.dart';
import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/getAttendeeViewModel.dart';
import 'package:attendencetracker/view_model/getEventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final isDialOpen = ValueNotifier(false);

  var _selectedTab = _SelectedTab.home;
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
    final getAttendeeViewModel = Provider.of<GetAttendeeViewModel>(context);

    eventViewModel = Provider.of<EventViewModel>(context);
    // String json = jsonEncode(eventViewModel.eventsList.data);
    // debugPrint("RESPONSE ${jsonDecode(json)}");

    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: SpeedDial(
          spacing: 12,
          spaceBetweenChildren: 10,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.delete),
              onTap: () {
                Navigator.pushNamed(context, RouteNames.deleteEvent);
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.add),
              onTap: () {
                Navigator.pushNamed(context, RouteNames.addEvent);
              },
            ),
          ],
          openCloseDial: isDialOpen,
          renderOverlay: false,
        ),
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
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 150,
                  ),
                  FutureBuilder<List<GetAttendees>?>(
                    future: getAttendeeViewModel.getAttendeeApi(
                        {"event_name": selectedType.toString()}, context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No Data Found',
                                style: TextStyle(
                                    color: ColorsClass.white, fontSize: 20)));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<GetAttendees>? attendeesData = snapshot.data;

                        return Text(
                          '${attendeesData?.length}',
                          style: GoogleFonts.oxygen(
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                              color: ColorsClass.white),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBarUtils(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          onTabTapped: _handleIndexChanged,
          onQRCodePressed: _onQRCodePressed,
        ),
      ),
    );
  }
}

enum _SelectedTab { home, qrCode, details }
