import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TaskItem with ChangeNotifier {
  final int id;
  final String name;
   final String categoryId;
   final String time;
  bool isDone;


   TaskItem({this.id, this.name, this.categoryId, this.time, this.isDone = false});
  Map<String ,dynamic> toMap(){
    return {
      'id': id,
      'name':name,
      'category':categoryId,
      'time':time,
      'done':isDone,
    };
  }
  void toggleDone() {
    isDone = !isDone;
    notifyListeners();
  }
}
