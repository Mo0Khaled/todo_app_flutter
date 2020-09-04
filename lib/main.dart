import 'package:flutter/material.dart';
import 'package:todoapp/models/task_data.dart';
import 'package:todoapp/screens/Home_page.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/screens/task_screen.dart';

import 'screens/timer_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

   runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskData(),
        ),

      ],
      child: Consumer<TaskData>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'ToDo App',
//            home: LocaleNotifications(),
            initialRoute: HomePage.routeId,
            routes: {
              HomePage.routeId: (context) => HomePage(),
              TaskScreen.routeId: (context) => TaskScreen(),
              TimerScreen.routeId:(context)=>TimerScreen(),
            },
          );
        },
      ),
    );
  }
}
