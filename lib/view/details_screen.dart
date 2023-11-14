// ignore_for_file: unused_field

import 'package:attendencetracker/model/getAttendees_model.dart';
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

  String? selectedType;

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
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      selectedType = value;
                      Map data = {
                        "event_name": selectedType.toString(),
                      };
                      getAttendeeViewModel.getAttendeeApi(data, context);
                    });
                  }
                },
              ),
            ),
            Positioned(
              top: 250,
              left: 16,
              right: 16,
              bottom: 160,
              // child: Placeholder(),
              child: FutureBuilder<List<GetAttendees>?>(
                future: getAttendeeViewModel.getAttendeeApi({"event_name": selectedType.toString()}, context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty){
                    return const Center(child: Text('No Data Found'));
                  }else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {

                    List<GetAttendees>? attendeesData = snapshot.data;

                    return ListView.builder(
                      itemCount: attendeesData?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text('Name: ${attendeesData?[index].name}'),
                            subtitle:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('ID: ${attendeesData?[index].id}'),
                                    Text('Email: ${attendeesData?[index].email}'),
                                    Text('Roll No: ${attendeesData?[index].rollNumber}'),
                                  ],
                                )
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Positioned(
              bottom: 110,
              left: 90,
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
        onQRCodePressed: _onQRCodePressed,
      ),
    );
  }
}

enum _SelectedTab { home, qrCode, details }
