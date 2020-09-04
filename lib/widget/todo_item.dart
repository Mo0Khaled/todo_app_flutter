import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/task_data.dart';
import 'package:todoapp/screens/task_screen.dart';
import '../models/todo.dart';

class ToDoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Todo>(
      builder: (context, taskPro, _) => InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(TaskScreen.routeId, arguments: taskPro.id),
        child: Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  taskPro.icon,
                  size: 40,
                  color: taskPro.colorIcon,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 5),
                  child: Text(
                    taskPro.title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "${Provider.of<TaskData>(context).filter(taskPro.id).length} Tasks",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
