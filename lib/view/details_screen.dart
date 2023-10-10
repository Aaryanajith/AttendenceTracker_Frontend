import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/tokenViewModel.dart';
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

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  var _selectedTab = _SelectedTab.details;

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
    final userPreference = Provider.of<TokenViewModel>(context);

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
                },
                value: selectedType, // Initial selected item
              ),
            ),
            Positioned(
              bottom: 100,
              child: InkWell(
              onTap: () {
                userPreference.remove().then((value){
                  Navigator.pushNamed(context, RouteNames.login);
                });
              },
              child: Text('Logout'),
            ))
          ], //add widgets here
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
