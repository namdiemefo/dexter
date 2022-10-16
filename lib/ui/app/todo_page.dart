import 'package:dexter_todo/core/blocs/todo/todo_cubit.dart';
import 'package:dexter_todo/data/models/shift.dart';
import 'package:dexter_todo/data/models/task.dart';
import 'package:dexter_todo/helpers/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      TodoCubit()
        ..getTasks(),
      child: _TodoPage(),
    );
  }
}


class _TodoPage extends StatefulWidget {
  @override
  __TodoPageState createState() => __TodoPageState();
}

class __TodoPageState extends State<_TodoPage> {

  List<Task> _tasks = [];
  List<Shift> _shifts = [];
  var _refreshController = RefreshController(initialRefresh: false);

  List<PopupMenuItem> shiftFilters(List<Shift> shifts) {
    List<PopupMenuItem> filters = shifts.map<PopupMenuItem>((e) => PopupMenuItem(
        value: e,
        child: Text(e.name)
    )).toList();
    return filters;
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext bigContext) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        // TODO: implement listener}
      },
      child: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {

          if (state is TodoList) {
            _tasks = state.tasks;
          }

          if (state is ShiftList) {
            _shifts = state.shifts;
          }

          return Scaffold(
            appBar: AppBar(
              actions: [
                // PopupMenuButton(
                //     itemBuilder: (_) => shiftFilters(_shifts),
                //     onSelected: (e) {
                //       if (e is Shift) {
                //         context.bloc<TodoCubit>().filterTasks(e.startTime, e.stopTime);
                //       }
                //     },
                // )
              ],
            ),
            body: SafeArea(
                top: false,
                child: Container(
                  decoration: BoxDecoration(),
                  child: SizedBox.expand(
                    child: SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      enablePullUp: false,
                      header: ClassicHeader(),
                      onRefresh: () {
                        // context.bloc<TodoCubit>().getTasks();
                      },
                      child: ListView.builder(
                          itemCount: _tasks.length,
                          itemBuilder: (BuildContext itemContext, int index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              height: 100,
                              child: CheckboxListTile(
                                title: Row(
                                  children: [
                                    Expanded(child: Text("${_tasks[index].note}")),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nurse: ${_tasks[index].user}"),
                                    Text("Shift: ${_tasks[index].shiftStartTime}:00 - ${_tasks[index].shiftStopTime}:00"),
                                    Text("Resident: ${_tasks[index].resident}")
                                  ],
                                ),
                                value: _tasks[index].status,
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                onChanged: (bool value) {
                                  context.bloc<TodoCubit>().markTask(value, _tasks[index].id);
                                  Future.delayed(Duration(seconds: 1), () {
                                    context.bloc<TodoCubit>().getTasks();
                                  });
                                },

                              ),
                            );
                          }
                      ),
                    ),
                  ),
                )
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(bigContext, AppRoutes.toCreateTaskScreen);
              },
              tooltip: 'Add Task',
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }


}
