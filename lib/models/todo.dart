import 'package:flutter/material.dart';

class Todo with ChangeNotifier {
  final String id;
  final String title;
  final String tasks;
  final IconData icon;
  final Color colorIcon;

  Todo({
    this.id,
    this.title,
    this.tasks,
    this.icon,
    this.colorIcon = Colors.orange,
  });
}
