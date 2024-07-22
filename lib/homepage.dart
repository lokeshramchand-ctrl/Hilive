// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unnecessary_import, library_private_types_in_public_api, avoid_print, unnecessary_null_comparison, unused_label

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hilive/data/database.dart';
import 'package:hilive/data/habit_database.dart';
import 'package:hilive/util/habit_tile.dart';
import 'package:hilive/util/month_summary.dart';
import 'package:hilive/util/my_alert_box.dart';
import 'package:hilive/util/my_fab.dart';
import 'package:hilive/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.red[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'hi',
              style: GoogleFonts.lobster(
                fontSize: screenSize.width *
                    0.75, // Adjust font size based on screen width
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w300,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red[300],
                minimumSize: Size(screenSize.width * 0.3,
                    screenSize.height * 0.08), // Adjust button size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_forward_ios_sharp),
                  SizedBox(width: 5),
                  Text('Get Started', style: TextStyle(color: Colors.red[300])),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => SecondRoute()),
                );
              },
            ),
            SizedBox(
              height: screenSize.height *
                  0.1, // Adjust spacing based on screen height
            ),
            Text(
              'Crafted by Lokesh',
              style: GoogleFonts.bowlbyOneSc(
                fontSize: screenSize.width *
                    0.05, // Adjust font size based on screen width
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  SecondRoute({super.key});

  // Define a list of tile names
  final List<String> tileNames = [
    'Habit Tracker',
    'To-Do List',
    'Calendar',
    'Calculator',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Menu',
            style: GoogleFonts.alumniSans(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.red[900],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.red[100],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            itemCount: tileNames
                .length, // The number of items in the grid, based on the length of the tileNames list
            padding: EdgeInsets.all(constraints.maxWidth *
                0.05), // Responsive padding around the grid, proportional to the screen width
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (constraints.maxWidth > 600)
                  ? 3
                  : 2, // Responsive column count: 3 columns for screens wider than 600, otherwise 2 columns
              childAspectRatio: 0.75 /
                  1.5, // Aspect ratio for each grid item, adjusted to fit the design requirements
              crossAxisSpacing: constraints.maxWidth *
                  0.10, // Responsive spacing between columns, proportional to the screen width
              mainAxisSpacing: constraints.maxWidth *
                  0.01, // Responsive spacing between rows, proportional to the screen width),
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // Define navigation for each tile
                  switch (index) {
                    case 0:
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => SecondPage()),
                      );
                      break;
                    case 1:
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => ToDoPage()),
                      );
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => CaLender()),
                      );
                      break;
                    case 3:
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => Calc()),
                      );
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Tile name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red[200],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Text(
                                tileNames[index],
                                style: TextStyle(
                                  color: Colors.red[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Other custom content can go here

                        // Icon and add button
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Icon
                              Icon(
                                Icons.favorite,
                                color: Colors.pink[600],
                              ),

                              // Plus button
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Dummy destination pages for navigation
class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");

  @override
  void initState() {
    // if there is no current habit list, then it is the 1st time ever opening the app
    // then create default data
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    }

    // there already exists data, this is not the first time
    else {
      db.loadData();
    }

    // update the database
    db.updateDatabase();

    super.initState();
  }

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  // create a new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    // show alert dialog for user to enter the new habit details
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: 'Enter habit name..',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save new habit
  void saveNewHabit() {
    // add new habit to todays habit list
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });

    // clear textfield
    _newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // cancel new habit
  void cancelDialogBox() {
    // clear textfield
    _newHabitNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
  }

  // open habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: db.todaysHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save existing habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 214, 226),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Habit Tracker',
              style: GoogleFonts.alumniSans(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900])),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 250, 214, 226),
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      body: ListView(
        children: [
          // monthly summary heat map
          MonthlySummary(
            datasets: db.heatMapDataSet,
            startDate: _myBox.get("START_DATE"),
          ),

          // list of habits
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: db.todaysHabitList[index][0],
                habitCompleted: db.todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          )
        ],
      ),
    );
  }
}

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
          hintText: 'Add new task..',
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 214, 226),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('ToDo List',
              style: GoogleFonts.alumniSans(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900])),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 250, 214, 226),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}

class CaLender extends StatefulWidget {
  const CaLender({super.key});

  @override
  State<CaLender> createState() => _CaLenderState();
}

class _CaLenderState extends State<CaLender> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Calendar',
              style: GoogleFonts.alumniSans(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900])),
        ),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        TableCalendar(
          availableGestures: AvailableGestures.all,
          focusedDay: today,
          firstDay: DateTime.utc(2010, 10, 6),
          lastDay: DateTime.utc(2030, 3, 14),
          calendarStyle: CalendarStyle(
            defaultTextStyle: TextStyle(color: Colors.white),
            weekendTextStyle: TextStyle(color: Colors.white),
            todayTextStyle: TextStyle(color: Colors.white),
            selectedTextStyle: TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
              color: Colors.red[400],
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.red[300],
              shape: BoxShape.circle,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.white),
            weekendStyle: TextStyle(color: Colors.white),
          ),
          headerStyle: HeaderStyle(
            titleTextStyle: TextStyle(color: Colors.white),
            formatButtonTextStyle: TextStyle(color: Colors.white),
            formatButtonDecoration: BoxDecoration(
              color: Colors.red[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class Calc extends StatefulWidget {
  _MyCalcPageState createState() => _MyCalcPageState();
}

class _MyCalcPageState extends State<Calc> {
  var test;
  static var userQuestion = '';
  var answer; //used to compute
  var displayAnswer = ''; //display final answer
  var colourTheme = Colors.deepPurple;
  static List<String> finalElements = [];
  static var editQuestion = '';

  void _buttonEqual() {
    answer = 0;

    editQuestion = userQuestion;

    for (var i = 0; i < editQuestion.length - 2; i++) {
      //check for Double Negation
      if (editQuestion[i] == '-' && editQuestion[i + 1] == '-') {
        // 1--2 -> 1+2
        editQuestion = editQuestion.substring(0, i) +
            '+' +
            editQuestion.substring(i + 2, editQuestion.length);
      }
    }

    for (var i = 1; i < editQuestion.length; i++) {
      //check for double plus
      if (editQuestion[i] == '+' && editQuestion[i - 1] == '+') {
        // 1+++2 -> 1+0+0+0+2
        editQuestion = editQuestion.substring(0, i) +
            '0' +
            editQuestion.substring(i, editQuestion.length);
      }
    }

    // +9 becomes 0+9
    if (editQuestion[0] == '+') {
      editQuestion = '0' + editQuestion;
    }

    //if the question starts with a number, add +0, this just helps with the addition functions
    if (startsWithNumber(editQuestion)) {
      editQuestion = '0+' + editQuestion;
    }

    //check if there's a '-' sign, execute subtraction
    for (var i = 0; i < editQuestion.length; i++) {
      if (editQuestion[i] == '-') {
        setState(() {
          _operateSubtraction();
        });
        break;
      }
    }

    //break up numbers separated by +
    finalElements = editQuestion.split("+");

    //this helps with multiplicativeOperation that uses split(x), there needs to be an x
    for (var i = 0; i < finalElements.length; i++) {
      if (finalElements[i].contains('/')) {
        finalElements[i] = "1×" + finalElements[i];
      }
    }

    //if theres a x symbol, execute multiplication
    for (var i = 0; i < finalElements.length; i++) {
      if (finalElements[i].contains('×')) {
        setState(() {
          _operateMultiplication();
        });
        break;
      }
    }

    //if there exists a '+' sign, execute addition
    for (var i = 0; i < editQuestion.length; i++) {
      if (editQuestion[i] == '+') {
        setState(() {
          _operateAddition();
        });
        break;
      }
    }

    displayAnswer = answer.toString();

    if (displayAnswer.endsWith('.0')) {
      displayAnswer = displayAnswer.substring(0, displayAnswer.length - 2);
    }
  }

  void _operateAddition() {
    for (var i = 0; i < finalElements.length; i++) {
      answer = answer + double.parse(finalElements[i]);
    }
  }

  //place a plus symbol infront of negative sign only if it doesn't have a sign before it
  void _operateSubtraction() {
    for (var i = 1; i < editQuestion.length; i++) {
      if (editQuestion[i] == '-' && !isOperator(editQuestion[i - 1])) {
        editQuestion = editQuestion.substring(0, i) +
            '+' +
            editQuestion.substring(i, editQuestion.length);
        i = i + 2;
      }
    }
  }

  static String _operateDivision(String abc) {
    double dividedResult;

    List<String> divisiveElements = abc.split("/");
    dividedResult =
        double.parse(divisiveElements[0]) / double.parse(divisiveElements[1]);

    if (divisiveElements.length > 2) {
      for (var k = 2; k < divisiveElements.length; k++) {
        dividedResult = dividedResult / double.parse(divisiveElements[k]);
      }
    }

    return dividedResult.toString();
  }

  void _operateMultiplication() {
    double multipliedResult;

    for (var i = 0; i < finalElements.length; i++) {
      if (finalElements[i].contains("×")) {
        List<String> multiplicativeElements = finalElements[i].split("×");

        //compute division first, then multiplication
        for (var k = 0; k < multiplicativeElements.length; k++) {
          if (multiplicativeElements[k].contains('/')) {
            multiplicativeElements[k] =
                _operateDivision(multiplicativeElements[k]);
          }
        }

        multipliedResult = double.parse(multiplicativeElements[0]) *
            double.parse(multiplicativeElements[1]);

        if (multiplicativeElements.length > 2) {
          for (var k = 2; k < multiplicativeElements.length; k++) {
            multipliedResult =
                multipliedResult * double.parse(multiplicativeElements[k]);
          }
        }

        finalElements[i] = multipliedResult.toString();
      }
    }
  }

  bool isOperator(String abc) {
    var x = abc[0];

    if (x == '+' || x == '-' || x == '×' || x == '/') {
      return true;
    }

    return false;
  }

  bool startsWithNumber(String abc) {
    var x = abc[0];

    if (x == '0' ||
        x == '1' ||
        x == '2' ||
        x == '3' ||
        x == '4' ||
        x == '5' ||
        x == '6' ||
        x == '7' ||
        x == '8' ||
        x == '9') {
      return true;
    }

    return false;
  }

  void _buttonPercent() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '%';
    });
  }

  void _buttonDel() {
    if (userQuestion.length == 0) {
    } else {
      setState(() {
        userQuestion = userQuestion.substring(0, userQuestion.length - 1);
      });
    }
  }

  void _buttonClr() {
    setState(() {
      userQuestion = '';
      displayAnswer = '';
    });
  }

  void _button7() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '7';
    });
  }

  void _button8() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '8';
    });
  }

  void _button9() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '9';
    });
  }

  void _button6() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '6';
    });
  }

  void _button5() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '5';
    });
  }

  void _button4() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '4';
    });
  }

  void _button3() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '3';
    });
  }

  void _button2() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '2';
    });
  }

  void _button1() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '1';
    });
  }

  void _button0() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '0';
    });
  }

  void _buttonDecimal() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '.';
    });
  }

  void _buttonDivide() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + '/';
    });
  }

  void _buttonMultiply() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
        userQuestion = 'Ans' + '×';
      } else {
        userQuestion = userQuestion + '×';
      }
    });
  }

  void _buttonSubtract() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
        userQuestion = 'Ans' + '-';
      } else {
        userQuestion = userQuestion + '-';
      }
    });
  }

  void _buttonAddition() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
        userQuestion = 'Ans' + '+';
      } else {
        userQuestion = userQuestion + '+';
      }
    });
  }

  void _buttonAns() {
    setState(() {
      if (displayAnswer.toString() != '') {
        _buttonClr();
      }
      userQuestion = userQuestion + 'Ans';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 214, 226),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Calculator',
              style: GoogleFonts.alumniSans(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900])),
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 25,
                ),
              )
            ],
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  userQuestion,
                  style: TextStyle(fontSize: 50, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.bottomRight,
              child: Text(
                displayAnswer.toString(),
                style: TextStyle(fontSize: 50, color: Colors.red[300]),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonDel,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                'DEL',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonClr,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                'C',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonPercent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '%',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonDivide,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '÷',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '7',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '8',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '9',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonMultiply,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '×',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '4',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '5',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '6',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonSubtract,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonAddition,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _button0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonDecimal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '.',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonAns,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                'ANS',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: _buttonEqual,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.red[300],
                            child: Center(
                              child: Text(
                                '=',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  height: 15,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
