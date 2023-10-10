// ignore: file_names
class EventList {
  String? eventName;
  String? startingDate;
  int? numOfDays;
  int? numOfSessions;

  EventList(
      {this.eventName, this.startingDate, this.numOfDays, this.numOfSessions});

  EventList.fromJson(Map<String, dynamic> json) {
    eventName = json['event_name'];
    startingDate = json['starting_date'];
    numOfDays = json['num_of_days'];
    numOfSessions = json['num_of_sessions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_name'] = eventName;
    data['starting_date'] = startingDate;
    data['num_of_days'] = numOfDays;
    data['num_of_sessions'] = numOfSessions;
    return data;
  }
}