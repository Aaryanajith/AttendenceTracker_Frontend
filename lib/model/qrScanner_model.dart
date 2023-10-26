// ignore_for_file: file_names

class QrScanner {
  String? date;
  String? time;
  int? session;
  int? id;

  QrScanner({this.date, this.time, this.session, this.id});

  QrScanner.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    session = json['session'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['session'] = session;
    data['id'] = id;
    return data;
  }
}