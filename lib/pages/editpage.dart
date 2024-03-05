import 'package:flutter/material.dart';
import 'package:flutter_todolist/data/database.dart';
import 'package:flutter_todolist/prop/button.dart';
import 'package:flutter_todolist/prop/date.dart';
import 'package:flutter_todolist/prop/priority.dart';

class editPage extends StatefulWidget {
  final controller;
  final String taskName;
  final String startDate;
  final String endDate;
  final datestartcontroller;
  final dateendcontroller;
  bool clicked;

  final Function(bool, int) updateClickedValue;
  // final ValueChanged<bool>? onPriorityChanged;

  final int index;
  VoidCallback onSave;
  editPage(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.index,
      required this.taskName,
      required this.startDate,
      required this.endDate,
      required this.datestartcontroller,
      required this.dateendcontroller,
      required this.clicked,
      required this.updateClickedValue
      // this.onPriorityChange,
      });

  @override
  State<editPage> createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  TodoDatabase db = TodoDatabase();
  @override
//    void _saveAndUpdateDatabase() {
//     setState(() {
//       // Update clicked value in widget
//       widget.clicked = !widget.clicked;

//       // Call callback to update state and save to database
//       widget.updateClickedValue(widget.clicked, widget.index);

//       // Save other data to database if needed

//     });
//    }
// }
  Widget build(BuildContext context) {
    // Variabel save for screen size
    double screeheight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, top: 32, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Center(
                  child: Text(
                    "Edit Data",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                SizedBox(
                    width:
                        40), // Untuk menjaga jarak antara tombol kembali dan teks
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Start",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                            width: screenWidth < 500
                                ? screenWidth * 0.17
                                : screenWidth < 900
                                    ? screenWidth * 0.29
                                    : screenWidth > 1100
                                        ? screenWidth * 0.332
                                        : screenWidth * 0.28),
                        Expanded(
                          child: Text(
                            "End",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: DateField(
                          text: widget.startDate,
                          datecontroller: widget.datestartcontroller,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: DateField(
                          text: widget.endDate,
                          datecontroller: widget.dateendcontroller,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 5, bottom: 2),
                          child: Text("Task"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25, bottom: 35),
                    child: TextField(
                      controller: widget.controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: widget.taskName,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, bottom: 25),
                        child: Text("Category"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PriorityButton(
                          screen: screenWidth / 3,
                          color:
                              widget.clicked ? Colors.deepPurple : Colors.white,
                          onPressed: () {
                            setState(() {
                              widget.clicked = !widget.clicked;
                              print(widget.clicked);
                              widget.updateClickedValue(
                                  widget.clicked, widget.index);

                              // widget.index4Changed = widget.clicked;
                              // db.toDolist[widget.index][4] = widget.clicked;
                            });
                          },
                          buttonpress: widget.clicked,
                          text: "Priority Task"),
                      PriorityButton(
                          color: !widget.clicked
                              ? Colors.deepPurple
                              : Colors.white,
                          screen: screenWidth / 3,
                          onPressed: () {
                            setState(() {
                              widget.clicked = !widget.clicked;
                              widget.updateClickedValue(
                                  widget.clicked, widget.index);
                              // widget.index4Changed = widget.clicked;
                            });
                          },
                          buttonpress: !widget.clicked,
                          text: "Daily task"),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Button(
                              color: Colors.deepPurple,
                              text: "Edit Task",
                              onPressed: widget.onSave),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
