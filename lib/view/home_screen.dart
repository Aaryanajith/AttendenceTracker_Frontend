import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/eventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomListItem extends StatelessWidget {
  final String title;

  const CustomListItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var _selectedTab = _SelectedTab.home;
  int? _selectedDropdownIndex;

  final List<String> _dropdownItems = ['Hacktoberfest', 'fossTalk', 'workshop'];
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
    // final eventView = Provider.of<EventViewModel>(context);

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
                )),
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
            Positioned(top: 200, left: 125, child: Text('Select Event Name')),
            Positioned(
              top: 250, // Adjust the position as needed
              left: 120, // Adjust the position as needed
              child: DropdownButton(
                items: _dropdownItems
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (selectedUserType) {
                  setState(() {
                    selectedType =
                        selectedUserType.toString(); // Update the selected item
                  });
                  // You can add any logic here to handle the selected item
                },
                value: selectedType, // Initial selected item
              ),
            ),
            Positioned(top: 500, left: 174, child: Text('count'))
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
