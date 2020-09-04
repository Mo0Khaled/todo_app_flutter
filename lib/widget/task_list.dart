import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/task_data.dart';
import 'package:todoapp/widget/task_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerTasks = Provider.of<TaskData>(context);
    final taskId = ModalRoute.of(context).settings.arguments as String;
    final loadedTask = Provider.of<TaskData>(context,listen: false).filter(taskId);//    final loaded = Provider.of<TaskData>(context).findById(taskId);
    return ListView.builder(
        itemCount: loadedTask.length,
        itemBuilder: (context, index) {
          final task = loadedTask[index];
          return TaskTile(
            taskTitle: task.name,
            subTitle: task.time,
            isChecked: task.isDone,
            checkBoxCallBack: (checkBoxState) {
              providerTasks.updateTask(task);
            },
            onLongPressCallBack: () {
              providerTasks.deleteTask(task);
            },
          );
        });
  }
}
