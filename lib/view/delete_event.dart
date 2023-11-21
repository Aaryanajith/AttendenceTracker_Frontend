import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/resources/components/round_button.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/deleteEventViewModel.dart';
import 'package:attendencetracker/view_model/getEventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<EventViewModel>(context);
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
                    const SizedBox(
                      child: Text('Select Event Name to Delete',
                          style: TextStyle(
                              color: ColorsClass.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 20,
                    ),
                    SizedBox(
                      width: 200,
                      child: DropdownButtonFormField<String>(
                        isExpanded: false,
                        hint: Text(
                          'Select Event',
                          style: GoogleFonts.oxygen(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: ColorsClass.white),
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
                          ),
                        ),
                        disabledHint: Text(
                          'Select Event',
                          style: GoogleFonts.oxygen(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: ColorsClass.white),
                        ),
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
                      height: 40,
                    ),
                    SizedBox(
                      width: 200,
                      child: RoundButton(
                        buttonName: 'Delete',
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: Text(
                                      'Are you sure you want to delete this event?',
                                      style: GoogleFonts.oxygen(
                                          fontWeight: FontWeight.normal,
                                          color: ColorsClass.black),
                                    ),
                                    actions: <Widget>[
                                      Center(
                                        child: SizedBox(
                                          width: 150,
                                          child: RoundButton(
                                              buttonName: 'Confirm',
                                              onPressed: () {
                                                Map data = {
                                                  'eventName': selectedType
                                                };
                                                deleteEventModel.deleteEvent(
                                                    data, context);
                                              }),
                                        ),
                                      )
                                    ],
                                  ));
                        },
                      ),
                    )
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
