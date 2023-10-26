import 'package:attendencetracker/resources/color.dart';
import 'package:attendencetracker/utlities/routes/route_names.dart';
import 'package:attendencetracker/utlities/utils.dart';
import 'package:attendencetracker/view_model/deleteEventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteEvent extends StatefulWidget {
  const DeleteEvent({Key? key}) : super(key: key);

  @override
  State<DeleteEvent> createState() => _DeleteEventState();
}

class _DeleteEventState extends State<DeleteEvent> {
  final TextEditingController _eventNameController = TextEditingController();

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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Column(
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
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_eventNameController.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                'Enter the event name', context);
                          } else {

                            Map data = {
                              "event_name": _eventNameController.text.toString()
                            };

                            deleteEventModel.deleteEvent(data, context);
                          }
                        },
                        child: const Text('Delete Event'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
