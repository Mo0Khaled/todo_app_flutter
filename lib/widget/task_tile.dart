import 'package:flutter/material.dart';
import 'package:todoapp/screens/timer_screen.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final String subTitle;
  final Function checkBoxCallBack;
  final Function onLongPressCallBack;
  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.subTitle,
      this.checkBoxCallBack,
      this.onLongPressCallBack});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onLongPress: onLongPressCallBack,
        title: Text(
          taskTitle,
          style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null),
        ),
        onTap: ()=> Navigator.of(context).pushNamed(TimerScreen.routeId,arguments: taskTitle),
        subtitle: Text(subTitle),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
          onChanged: checkBoxCallBack,
        ));
  }
}
