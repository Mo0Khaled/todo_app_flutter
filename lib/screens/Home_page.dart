import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/task_data.dart';
import '../screens/add_task.dart';
import '../widget/todo_item.dart';

class HomePage extends StatelessWidget {
  static const routeId = '/home';
  @override
  Widget build(BuildContext context) {
    final providerTasks = Provider.of<TaskData>(context);
    final tasksList = providerTasks.lists;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.stream,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Lists",
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 120),
              child: FutureBuilder(
                future: Provider.of<TaskData>(context,listen: false).fetchData(),
                builder:(context,snapshot)=> GridView.builder(
                  itemCount: tasksList.length,
                  itemBuilder: (context, index) => ChangeNotifierProvider.value(
                    value: tasksList[index],
                    child: ToDoItem(),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => AddTask());
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Color(0xFF5886FF),
      ),
    );
  }
}
