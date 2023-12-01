// ignore_for_file: unused_field;
import 'package:attendencetracker/model/getAttendees_model.dart';
import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/resources/components/round_button.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/getAttendeeViewModel.dart';
import 'package:attendencetracker/view_model/getEventViewModel.dart';
import 'package:attendencetracker/view_model/tokenViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
        color: ColorsClass.lightBlack,
        child: Stack(children: [
          Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 120,
              ),
              const SizedBox(
                child: Text('Select Event',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              SizedBox(
                width: 250,
                child: DropdownButtonFormField<String>(
                  isExpanded: false,
                  hint: Text(
                    'Select Event',
                    style: GoogleFonts.oxygen(
                        color: ColorsClass.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: InputDecoration(
                      fillColor: ColorsClass.amber,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorsClass.amber, width: 2),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      )),
                  disabledHint: Text(
                    'Select Event',
                    style: GoogleFonts.oxygen(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ColorsClass.white),
                  ),
                  dropdownColor: ColorsClass.amber,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: ColorsClass.white,
                  ),
                  iconDisabledColor: Colors.blue,
                  iconEnabledColor: ColorsClass.white,
                  items: eventNames?.map((name) {
                    return DropdownMenuItem<String>(
                      value: name,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(65, 0, 0, 0),
                        child: Text(
                          name,
                          style: GoogleFonts.oxygen(
                              color: ColorsClass.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                  value: selectedType,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedType = value;
                      });
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 350,
                  height: 500,
                  child: FutureBuilder<List<GetAttendees>?>(
                    future: getAttendeeViewModel.getAttendeeApi(
                        {"event_name": selectedType.toString()}, context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return shimmmerLoading();
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: Text('No Data Found',
                                style: GoogleFonts.oxygen(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsClass.white,
                                )));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<GetAttendees>? attendeesData = snapshot.data;
                        return ListView.builder(
                          itemCount: attendeesData?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 12,
                              shadowColor: ColorsClass.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              color: ColorsClass.amber,
                              child: ListTile(
                                  title: Text(
                                    'Name: ${attendeesData?[index].name}',
                                    style: GoogleFonts.oxygen(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: ColorsClass.black,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID: ${attendeesData?[index].id}',
                                        style: GoogleFonts.oxygen(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: ColorsClass.white),
                                      ),
                                      Text(
                                        'Email: ${attendeesData?[index].email}',
                                        style: GoogleFonts.oxygen(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: ColorsClass.white),
                                      ),
                                      Text(
                                        'Roll No: ${attendeesData?[index].rollNumber}',
                                        style: GoogleFonts.oxygen(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: ColorsClass.white),
                                      ),
                                    ],
                                  )),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.002),
              SizedBox(
                width: 180,
                height: 45,
                child: RoundButton(
                  buttonName: "Logout",
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: Text(
                                'Are you sure you want to logout?',
                                style: GoogleFonts.oxygen(
                                    fontWeight: FontWeight.normal,
                                    color: ColorsClass.black),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      userPreference.remove().then((value) {
                                        Navigator.pushNamed(
                                            context, RouteNames.login);
                                      });
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(fontSize: 15),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(fontSize: 15),
                                    )),
                              ],
                            )));
                  },
                ),
              )
            ],
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBarUtils(
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        onTabTapped: _handleIndexChanged,
        onQRCodePressed: _onQRCodePressed,
      ),
    );
  }

  shimmmerLoading() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => Card(
          elevation: 12,
          shadowColor: ColorsClass.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          color: ColorsClass.amber,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: ColorsClass.lightBlack,
                    highlightColor: const Color.fromARGB(255, 200, 200, 200),
                    child: Container(
                      width: 80,
                      height: 8,
                      color: ColorsClass.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: ColorsClass.white,
                    highlightColor: const Color.fromARGB(255, 200, 200, 200),
                    child: Container(
                      width: 200,
                      height: 8,
                      color: ColorsClass.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: ColorsClass.white,
                    highlightColor: const Color.fromARGB(255, 200, 200, 200),
                    child: Container(
                      width: 200,
                      height: 8,
                      color: ColorsClass.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: ColorsClass.white,
                    highlightColor: const Color.fromARGB(255, 200, 200, 200),
                    child: Container(
                      width: 200,
                      height: 8,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

enum _SelectedTab { home, qrCode, details }
