import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/task_data.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String dropdownValue = 'All';

//  DateTime _selectedDate;
  String newTitle;

  // start time picker
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;

  Future<void> selectedTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: _time);
    if (picked == null) {
      return;
    }
    setState(() {
      _time = picked;
    });
  }

  //end here
  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('croconileicon');
    var initializationSettingsIos = IOSInitializationSettings();
    var initSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIos);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }
  Future onSelectNotification(String payload) {}



  Future<void> showNotifications() async{
    var time = Time(_time.hour,_time.minute,0);
    var android = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.Max,
      priority: Priority.High,
      ongoing: true,
      autoCancel: true,
    );
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android, ios);
   await flutterLocalNotificationsPlugin.showDailyAtTime(0,"Your Task : $newTitle Start Now!","Let\'s Do it", time,platform,
    payload: "$_time");
    }

  //  void _presentDatePicker() {
//    showDatePicker(
//            context: context,
//            initialDate: DateTime.now(),
//            firstDate: DateTime(2020),
//            lastDate: DateTime.now())
//        .then((pickedDate) {
//      if (pickedDate == null) {
//        return;
//      }
//      setState(() {
//        _selectedDate = pickedDate;
//      });
//    });
//  }
  @override
  Widget build(BuildContext context) {
    final addTaskProvider = Provider.of<TaskData>(context);
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFF757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'New Task',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                TextField(
                  autofocus: false,
                  textAlign: TextAlign.center,
                  maxLength: 20,
                  onChanged: (newText) {
                    newTitle = newText;
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                Divider(
                  color: Colors.grey,
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(FontAwesomeIcons.bell),
                      onPressed: () => selectedTime(context),
                      color: Colors.blue,
                    ),
                    Text(picked == null
                        ? "No Date Chosen"
                        : 'Picked Date: ${_time.hourOfPeriod}:${_time.minute}'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(FontAwesomeIcons.stickyNote),
                      onPressed: () {},
                      color: Colors.blue,
                    ),
                    Text("Add Note"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(FontAwesomeIcons.certificate),
                      onPressed: () {},
                      color: Colors.blue,
                    ),
                    Text("Category"),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.blueAccent),
                      underline: Container(
                        height: 2,
                        color: Colors.blueAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        'All',
                        'Work',
                        'Music',
                        'Travel',
                        'Study',
                        'Home'
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 28,
                ),
                RaisedButton(
                  onPressed: () async {
                    addTaskProvider.addTask(
                      newTaskTitle: newTitle,
                      category: dropdownValue,
                      time: picked == null
                          ? "No Date Chosen"
                          : "Time To Work: " +
                              _time.hourOfPeriod.toString() +
                              ":" +
                              _time.minute.toString(),
                    );
                    showNotifications();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Create",
                    style: TextStyle(fontSize: 17),
                  ),
                  color: Color(0xFF5886FF),
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 130),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
