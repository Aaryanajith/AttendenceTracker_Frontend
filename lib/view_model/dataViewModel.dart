import 'package:flutter/material.dart';
import 'package:/attendencetracker/repositories/data_repository.dart';

class DataViewModel with ChangeNotifier {
  final _myData = DataRepository();

  Future<void> DataApi(dynamic data, BuildContext context) async {
    _myData.dataApi(data).then((value) {}).onError((error, stackTrace){});
  }
}
