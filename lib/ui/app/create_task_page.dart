import 'package:dexter_todo/core/blocs/task/task_cubit.dart';
import 'package:dexter_todo/data/models/nurse.dart';
import 'package:dexter_todo/data/models/resident.dart';
import 'package:dexter_todo/data/models/shift.dart';
import 'package:dexter_todo/data/models/task.dart';
import 'package:dexter_todo/helpers/assets/colors.dart';
import 'package:dexter_todo/helpers/utils/funcs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CreateTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..getLists(),
      child: _CreateTaskPage(),
    );
  }
}


class _CreateTaskPage extends StatefulWidget {
  @override
  __CreateTaskPageState createState() => __CreateTaskPageState();
}

class __CreateTaskPageState extends State<_CreateTaskPage> {

  final _formKey = GlobalKey<FormState>();
  String _note, nurse;
  Nurse _nurse;
  Shift _shift;
  Resident _resident;
  List<Nurse> nurses = [];
  List<Shift> shifts = [];
  List<Resident> residents = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {

          if (state is GetList) {
            nurses = state.nurses;
            residents = state.residents;
            shifts = state.shifts;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Create Task'),
            ),
            body: SafeArea(
              top: false,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.83,
                                  height: 100.0,
                                  child: TextFormField(
                                    maxLines: 100,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: 'Write the task here....',
                                      border: InputBorder.none,
                                      fillColor: AppUtils.hexToColor('#EEEBEA'),
                                      filled: true,
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: AppUtils.hexToColor('#D5D5D5'),
                                              width: 1.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: AppUtils.hexToColor('#D5D5D5'),
                                              width: 1.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: AppUtils.hexToColor('#D5D5D5'),
                                              width: 1.0)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                          BorderSide(color: bRedCard, width: 1.0)),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter a task';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                    ),
                                    onSaved: (value) {
                                      _note = value;
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),

                          SizedBox(
                            height: 25,
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: DropdownButton<Nurse>(
                                  // icon: const Icon(Icons.keyboard_arrow_down),
                                  hint: Text("Select Nurse"),
                                  items: nurses.map((e) => DropdownMenuItem<Nurse>(
                                      child: Text(e.name),
                                      value: e,
                                  )).toList(),
                                    value: _nurse,
                                    onChanged: (Nurse value) {
                                      setState(() {
                                        _nurse = value;
                                      });
                                    },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 25,
                          ),


                          Row(
                            children: [
                              Expanded(
                                  child: DropdownButton<Resident>(
                                    hint: Text("Select Resident"),
                                    items: residents.map((e) => DropdownMenuItem<Resident>(child: Text(e.name), value: e)).toList(),
                                    value: _resident,
                                    onChanged: (Resident value) {
                                      setState(() {
                                        _resident = value;
                                      });
                                    },
                                  ),
                              )
                            ],
                          ),

                          SizedBox(
                            height: 25,
                          ),



                          Row(
                            children: [
                              Expanded(
                                  child: DropdownButton<Shift>(
                                    hint: Text("Select Shift"),
                                    items: shifts.map((e) => DropdownMenuItem<Shift>(child: Text(e.name), value: e)).toList(),
                                    value: _shift,
                                    onChanged: (Shift value) {
                                      setState(() {
                                        _shift = value;
                                      });
                                    },
                                  )
                              )
                            ],
                          ),

                          SizedBox(
                            height: 25,
                          ),

                          Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      _formKey.currentState.save();
                                      if (_note == null || _nurse == null || _resident == null || _shift == null) {
                                        final scaffold = ScaffoldMessenger.of(context);
                                        scaffold.showSnackBar(SnackBar(content: Text("All fields must be entered")));
                                      } else {
                                        var uuid = Uuid();
                                        Task _task = Task(note: _note, id: uuid.v4(), user: _nurse.name, resident: _resident.name, shiftStartTime: _shift.startTime, shiftStopTime: _shift.stopTime, status: false);
                                        context.bloc<TaskCubit>().createTask(_task);
                                      }

                                    },
                                  ),
                              )
                            ],
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
);
  }
}
