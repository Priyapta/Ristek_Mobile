import 'package:flutter/material.dart';
import 'package:flutter_todolist/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DateField extends StatefulWidget {
  final text;
  TextEditingController datecontroller = TextEditingController();
  DateField({super.key, required this.text, required this.datecontroller});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  final _mybox = Hive.openBox('mybox');
  TodoDatabase db = TodoDatabase();
  DateTime? _lastPickedDate;

  @override
  Widget build(BuildContext context) {
    double screeheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      height: screeheight / 17,
      width: screenwidth / 3.2,
      //
      child: TextField(
        controller: widget.datecontroller,
        decoration: InputDecoration(
          labelText: widget.text,
          filled: true,
          prefixIcon: Icon(Icons.calendar_today),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        readOnly: true,
        onTap: () {
          _selectdate();
        },
      ),
    );
  }

  Future<void> _selectdate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate:
          _lastPickedDate ?? DateTime.now(), //kemungkinan harus di rubah
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        widget.datecontroller.text = _picked.toString().split(" ")[0];
        db.toDolist.add(widget.datecontroller.text);
      });
    }
  }
}
