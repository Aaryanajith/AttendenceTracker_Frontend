import 'dart:convert';
import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/getEventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
                left: 120,
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
