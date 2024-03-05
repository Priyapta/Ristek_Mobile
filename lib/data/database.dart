import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';

class TodoDatabase {
  List toDolist = [];
  // reference box

  final _mybox = Hive.box('mybox');

  void createInitalData() {
    // {task,checkbox,start date,end date,priority}
    toDolist = [];
  }

  // load
  void loadData() {
    toDolist = _mybox.get("TODOLIST");
  }

  // update
  void updateDatabase() {
    _mybox.put("TODOLIST", toDolist);
  }
}
