import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/createEventModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        appBar: Utils.appBar(
          'Create Event',
          automaticallyImplyLeading: true,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          'Enter the event name',
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorsClass.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter the event name'),
                            controller: _eventNameController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                            ],
                            decoration: const InputDecoration(
                                labelText: 'Enter the no of days of event'),
                            controller: _numOfDaysController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                                labelText: 'Enter the number of sessions'),
                            controller: _numOfSessionController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            _showDatePicker();
                          },
                          child: const Text('Choose starting date'),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                              'Chosen date: ${DateFormat('dd/MM/yyyy').format(_dateTime)}'
                                  .toString())),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
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
                              debugPrint(DateFormat("dd/MM/yyyy")
                                  .format(_dateTime)
                                  .toString());
                              debugPrint(_numOfDaysController.text);
                              debugPrint(_numOfSessionController.text);
            
                              Map data = {
                                "event_name": _eventNameController.text.toString(),
                                "starting_date":DateFormat("dd/MM/yyyy").format(_dateTime),
                                "num_of_days": _numOfDaysController.text,
                                "num_of_sessions":_numOfSessionController.text
                              };
                              getEventModel.createEvent(data, context);
                            }
                          },
                          child: const Text('Submit'),
                        ),
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
