// ignore_for_file: file_names

class GetAttendees {
  int? id;
  String? name;
  String? email;
  String? rollNumber;
  AttendenceLog? attendenceLog;
  MiscLog? miscLog;
  String? eventName;

  GetAttendees(
      {this.id,
      this.name,
      this.email,
      this.rollNumber,
      this.attendenceLog,
      this.miscLog,
      this.eventName});

  GetAttendees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    rollNumber = json['roll_number'];
    attendenceLog = json['attendence_log'] != null
        ? AttendenceLog.fromJson(json['attendence_log'])
        : null;
    miscLog = json['misc_log'] != null
        ? MiscLog.fromJson(json['misc_log'])
        : null;
    eventName = json['event_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['roll_number'] = rollNumber;
    if (attendenceLog != null) {
      data['attendence_log'] = attendenceLog!.toJson();
    }
    if (miscLog != null) {
      data['misc_log'] = miscLog!.toJson();
    }
    data['event_name'] = eventName;
    return data;
  }

  map(Map<String, dynamic> Function(dynamic attendee) param0) {}
}

class AttendenceLog {
  List<Log>? log;

  AttendenceLog({this.log});

  AttendenceLog.fromJson(Map<String, dynamic> json) {
    if (json['log'] != null) {
      log = <Log>[];
      json['log'].forEach((v) {
        log!.add(Log.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (log != null) {
      data['log'] = log!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Log {
  String? date;
  bool? session1;
  bool? session2;

  Log({this.date, this.session1, this.session2});

  Log.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    session1 = json['session1'];
    session2 = json['session2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['session1'] = session1;
    data['session2'] = session2;
    return data;
  }
}

class MiscLog {
  List<Log>? log;

  MiscLog({this.log});

  MiscLog.fromJson(Map<String, dynamic> json) {
    if (json['log'] != null) {
      log = <Log>[];
      json['log'].forEach((v) {
        log!.add(Log.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (log != null) {
      data['log'] = log!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
