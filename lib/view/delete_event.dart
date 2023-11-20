import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/deleteEventViewModel.dart';
import 'package:attendencetracker/view_model/getEventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteEvent extends StatefulWidget {
  const DeleteEvent({Key? key}) : super(key: key);

  @override
  State<DeleteEvent> createState() => _DeleteEventState();
}

class _DeleteEventState extends State<DeleteEvent> {
  int? _selectedDropdownIndex;

  EventViewModel eventViewModel = EventViewModel();
  String? selectedType;
  List<String>? eventNames;

  @override
  Widget build(BuildContext context) {
    final deleteEventModel = Provider.of<DeleteEventModel>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(
            context, RouteNames.home); // Navigate back to the home page
        return true;
      },
      child: Scaffold(
        appBar: Utils.appBar(
          'Delete Event',
          automaticallyImplyLeading: true,
        ),
        extendBodyBehindAppBar: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
                    SizedBox(
                      child: Text('Select Event Name to Delete',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
