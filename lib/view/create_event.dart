import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/resources/components/round_button.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/createEventModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2015),
            lastDate: DateTime(2050))
        .then((value) => {
              setState(() {
                _dateTime = value!;
              })
            });
  }

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _numOfDaysController = TextEditingController();
  final TextEditingController _numOfSessionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final getEventModel = Provider.of<CreateEventModel>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(
            context, RouteNames.home); // Navigate back to the home page
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Utils.appBar(
          'Create Event',
          automaticallyImplyLeading: true,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: ColorsClass.lightBlack,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        height: 120,
                      ),
                      SizedBox(
                        child: Text(
                          'Enter Event Details',
                          style: GoogleFonts.oxygen(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 50,
                      ),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          style: const TextStyle(color: ColorsClass.white),
                          decoration: const InputDecoration(
                            hintText: 'Event Name',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsClass.amber),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsClass.amber),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          controller: _eventNameController,
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 30,
                      ),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: const InputDecoration(
                            hintText: 'Number of Days',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsClass.amber),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsClass.amber),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          controller: _numOfDaysController,
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 30,
                      ),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: const InputDecoration(
                            hintText: 'Number of Sessions',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsClass.amber),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsClass.amber),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          controller: _numOfSessionController,
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 30,
                      ),
                      SizedBox(
                          child: Text('Select Date',
                              style: GoogleFonts.oxygen(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          onTap: _showDatePicker,
                          readOnly: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText:
                                (DateFormat('dd-MM-yyyy').format(_dateTime)),
                            hintStyle: const TextStyle(color: Colors.white),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsClass.amber),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: ColorsClass.amber),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 60,
                      ),
                      SizedBox(
                        width: 200,
                        child: RoundButton(
                            buttonName: 'Submit',
                            onPressed: () {
                              if (_eventNameController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                    'Please enter the event name', context);
                              } else if (_numOfDaysController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                    'Please enter number of days of event',
                                    context);
                              } else if (_numOfSessionController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                    'Please enter number of sessions of the event',
                                    context);
                              } else {
                                Map data = {
                                  "event_name":
                                      _eventNameController.text.toString(),
                                  "starting_date": DateFormat("dd/MM/yyyy")
                                      .format(_dateTime),
                                  "num_of_days": _numOfDaysController.text,
                                  "num_of_sessions":
                                      _numOfSessionController.text
                                };
                                getEventModel.createEvent(data, context);
                              }
                            }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
