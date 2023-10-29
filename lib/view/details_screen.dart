// ignore_for_file: unused_field

import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/resources/components/round_buttom.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/getAttendeeViewModel.dart';
import 'package:attendencetracker/view_model/getEventViewModel.dart';
import 'package:attendencetracker/view_model/tokenViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  var _selectedTab = _SelectedTab.details;
  int? _selectedDropdownIndex;

  EventViewModel eventViewModel = EventViewModel();
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

  String? selectedType; // Variable to store the selected dropdown item

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
    final userPreference = Provider.of<TokenViewModel>(context);
    eventViewModel = Provider.of<EventViewModel>(context);

    final getAttendeeViewModel = Provider.of<GetAttendeeViewModel>(context);
    // final dynamic result =
    //     getAttendeeViewModel.getAttendeeApi(selectedType);
    // List<Map<String, dynamic>> attendeesData =
    //     (result as List<Map<String, dynamic>>) ?? [];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Utils.appBar(
        'Query Page',
        automaticallyImplyLeading: false,
      ),
      extendBody: true,
      body: Container(
        color: ColorsClass.white,
        child: Stack(
          children: [
            const Positioned(
                top: 100,
                left: 80,
                child: Text('Select Event Name to display details')),
            Positioned(
              top: 175, // Adjust the position as needed
              left: 120, // Adjust the position as needed
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
                    getAttendeeViewModel.getAttendeeApi(value, context);
                  });
                },
              ),
            ),
            const Positioned(
              top: 250, // Adjust the position as needed
              left: 16, // Adjust the position as needed
              right: 16, // Adjust the position as needed
              bottom: 160, // Adjust the position as needed
              // child: attendeesData.isEmpty
              //     ? const Center(child: Text('No attendees to display'))
              //     : ListView.builder(
              //         itemCount: attendeesData.length,
              //         itemBuilder: (context, index) {
              //           final attendee = attendeesData[index];
              //           return Card(
              //             margin: EdgeInsets.only(bottom: 16),
              //             child: ListTile(
              //               title: Text('ID: ${attendee['id']}'),
              //               subtitle: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text('Name: ${attendee['name']}'),
              //                   Text('Email: ${attendee['email']}'),
              //                   Text('Roll Number: ${attendee['roll_number']}'),
              //                 ],
              //               ),
              //             ),
              //           );
              //         },
              //       ),
              child: Placeholder(),
            ),
            Positioned(
              bottom: 100,
              left: 150,
              child: RoundButton(
                onPressed: () {
                  userPreference.remove().then((value) {
                    Navigator.pushNamed(context, RouteNames.login);
                  });
                },
                buttonName: "Logout",
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarUtils(
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        onTabTapped: _handleIndexChanged,
        onQRCodePressed: _onQRCodePressed, // Pass the callback here
      ),
    );
  }
}

enum _SelectedTab { home, qrCode, details }
