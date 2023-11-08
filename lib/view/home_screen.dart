import 'dart:convert';
import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/getEventViewModel.dart';
import 'package:attendencetracker/view_model/tokenViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var _selectedTab = _SelectedTab.home;
  // ignore: unused_field
  int? _selectedDropdownIndex;
  Future? refreshToken;

  TokenViewModel tokenViewModel = TokenViewModel();

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
    String json = jsonEncode(eventViewModel.eventsList.data);
    debugPrint("RESPONSE ${jsonDecode(json)}");

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Utils.appBar(
        'amFOSS Attendence Tracker',
        automaticallyImplyLeading: false,
      ),
      extendBody: true,
      body: Container(
        color: ColorsClass.white,
        child: Stack(
          children: [
            Positioned(
              top: 100,
              left: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: ColorsClass.amber,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.addEvent);
                },
                child: const Text(
                  'Create Event',
                  style: TextStyle(
                    fontSize: 25,
                    color: ColorsClass.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: ColorsClass.amber,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.deleteEvent);
                },
                child: const Text(
                  'Delete Event',
                  style: TextStyle(
                    fontSize: 25,
                    color: ColorsClass.white,
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 200,
              left: 125,
              child: Text('Select Event Name'),
            ),
            Positioned(
                top: 250,
                left: 135,
                child: DropdownButton<String>(
                  items: eventNames?.map((name) {
                    return DropdownMenuItem<String>(
                      value: name,
                      child: Text(name),
                    );
                  }).toList(),
                  value: selectedType,
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                )),
            const Positioned(
              top: 500,
              left: 174,
              child: Text('count'),
            ),
            Positioned(
                top: 650,
                right: 20,
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80)),
                        backgroundColor: ColorsClass.amber),
                    onPressed: () async {
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.remove('token');

                      //get the refresh token

                      refreshToken = tokenViewModel.getRefresh();
                      debugPrint(refreshToken as String?);
                      //make a request to the refresh end point
                      //store the token I get
                    },
                    child: const Icon(Icons.refresh),
                  ),
                ))
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
