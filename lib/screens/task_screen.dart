import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/task_data.dart';
import 'package:todoapp/widget/task_list.dart';

class TaskScreen extends StatelessWidget {
  static const routeId = '/task-screen';
  @override
  Widget build(BuildContext context) {
    final taskId = ModalRoute.of(context).settings.arguments as String;
    final loadedTask = Provider.of<TaskData>(context).findById(taskId);
    return SafeArea(
      child: Scaffold(
        backgroundColor: loadedTask.colorIcon,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(
                      loadedTask.icon,
                      size: 50,
                      color: loadedTask.colorIcon,
                    ),
                    backgroundColor: Colors.white,
                    radius: 40,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    loadedTask.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                    ),
                  ),
                  Text(
                    '${Provider.of<TaskData>(context).filter(taskId).length} Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Provider.of<TaskData>(context).filter(taskId).length == 0 ? Center(child: Text("No Items"),) : TaskList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
