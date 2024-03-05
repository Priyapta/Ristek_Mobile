import 'package:flutter/material.dart';
import 'package:flutter_todolist/data/database.dart';
import 'package:flutter_todolist/prop/button.dart';
import 'package:flutter_todolist/prop/date.dart';
import 'package:flutter_todolist/prop/priority.dart';

class DialogBox extends StatefulWidget {
  final controller;
  final dateController;
  final dateEndController;
  VoidCallback onSave;
  bool clicked;
  final int index;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.dateController,
      required this.dateEndController,
      required this.clicked,
      required this.index});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  void _saveClickedValue() {
    setState(() {
      // Simpan nilai widget.clicked ke dalam database
      db.toDolist[widget.index][4] = widget.clicked;
    });
  }

  TodoDatabase db = TodoDatabase();
  @override
  Widget build(BuildContext context) {
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
                    "Add Data",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Start"),
                        Text("End"),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: DateField(
                          text: "Enter Start",
                          datecontroller: widget.dateController,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: DateField(
                          text: "Enter End",
                          datecontroller: widget.dateEndController,
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
                          padding: const EdgeInsets.only(top: 12.0, left: 5),
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
                        hintText: "Enter your Task",
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text("Category"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PriorityButton(
                          color:
                              widget.clicked ? Colors.deepPurple : Colors.white,
                          screen: screenWidth / 3,
                          onPressed: () {
                            setState(() {
                              widget.clicked = !widget.clicked;
                              // widget.index4Changed = widget.clicked;
                              // db.toDolist[widget.index][4] = widget.clicked;
                            });
                          },
                          buttonpress: widget.clicked,
                          text: "Priority Task"),
                      // SizedBox(
                      //   width: 80,
                      // ),
                      PriorityButton(
                          color: !widget.clicked
                              ? Colors.deepPurple
                              : Colors.white,
                          screen: screenWidth / 3,
                          onPressed: () {
                            setState(() {
                              widget.clicked = !widget.clicked;
                              // widget.index4Changed = widget.clicked;
                              // db.toDolist[widget.index][4] = widget.clicked;
                            });
                          },
                          buttonpress: !widget.clicked,
                          text: "Daily Task"),
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
                            text: "Add Task",
                            onPressed: () {
                              widget.onSave();
                              
                            }),
                      )),
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
