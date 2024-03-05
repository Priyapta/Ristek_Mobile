import 'package:flutter/material.dart';
import 'package:flutter_todolist/data/database.dart';
import 'package:flutter_todolist/pages/addTask.dart';
import 'package:flutter_todolist/pages/editpage.dart';
// import 'package:flutter_todolist/pages/task.dart';
import 'package:flutter_todolist/prop/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _nameState();
}

class _nameState extends State<HomePage> {
  // reference box
  final _mybox = Hive.box('mybox');

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _editcontroller = TextEditingController();
  final TextEditingController _editdatecontroller = TextEditingController();
  final TextEditingController _editstartcontroller = TextEditingController();
  TodoDatabase db = TodoDatabase();
  int indexing = 0;
  // bool a = db.toDolist[indexing][4];

  @override
  void initState() {
    // if 1 time creatae defaul data
    indexing = db.toDolist.length;
    if (_mybox.get("TODOLIST") == null) {
      db.createInitalData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // checkbox value
  void checkBox(bool? value, int index) {
    setState(() {
      db.toDolist[index][1] = !db.toDolist[index][1];
    });
  }

// function return to save new task
  void newSaveTask() {
    setState(() {
      db.toDolist.add([_controller.text, false, "", "", false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // Edit Task
  void newEditTask(int index, bool clicked) {
    setState(() {
      String newtext = _editcontroller.text;
      String datestart = _editstartcontroller.text;
      String dateend = _editdatecontroller.text;
      if (newtext != null && newtext.isNotEmpty) {
        db.toDolist[index][0] = _editcontroller.text;
      }
      if (datestart != null && datestart.isNotEmpty) {
        db.toDolist[index][2] = datestart;
      }
      if (dateend != null && dateend.isNotEmpty) {
        db.toDolist[index][3] = dateend;
      }
      db.toDolist[index][4] = clicked;
      // db.toDolist[index][4] = a;

      // Use text property to get the text from the controller

      // Use text property to get the text from the controller
      _editcontroller.clear();
      _editdatecontroller.clear();
      _editstartcontroller.clear();
      // Clear both controllers after updating the values
    });
    // Navigator.pop(context);
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void EditTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return editPage(
          controller: _editcontroller,
          onSave: () => newEditTask(index, false),
          index: index,
          taskName: db.toDolist[index][0],
          startDate: db.toDolist[index][2],
          endDate: db.toDolist[index][3],
          clicked: db.toDolist[index][4] = false,
          updateClickedValue: (bool clicked, int index) {
            // Function to update clicked value in the database

            db.toDolist[index][4] = clicked;
          },
          datestartcontroller: _editstartcontroller,
          dateendcontroller: _editdatecontroller,

          // Pass the task name to the editPage
        );
      },
    );
  }

  void createNewList() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          index: indexing,
          controller: _controller,
          onSave: newSaveTask,
          clicked: false,
          dateController: _editstartcontroller,
          dateEndController: _editdatecontroller,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int indexing;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text("TO DO")),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, "/addtask");
                        createNewList();
                        print(db.toDolist[0][4]);

                        // db.toDolist[4] = ["lala", false];
                      },
                      child: Text("Add Task")),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: db.toDolist.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  onTap: () {
                    print(db.toDolist[index][4]);
                    // print(indexing);
                    EditTask(index);
                  },
                  taskName: db.toDolist[index][0],
                  taskComplete: db.toDolist[index][1],
                  onChanged: (value) => checkBox(value, index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
