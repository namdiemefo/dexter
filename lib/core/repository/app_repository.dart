
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_todo/core/repository/app_reporitory_interface.dart';
import 'package:dexter_todo/data/models/nurse.dart';
import 'package:dexter_todo/data/models/resident.dart';
import 'package:dexter_todo/data/models/shift.dart';
import 'package:dexter_todo/data/models/task.dart';

class AppRepository extends AppRepositoryInterface {

  final db = FirebaseFirestore.instance;

  @override
  createTask(Task task) async {
    await db.collection("tasks").add(task.toJson());
  }

  @override
  markTask(bool value, String id) async {
    print(id);
    QuerySnapshot tasks = await db.collection("tasks").where("id", isEqualTo: id).get();
    print(tasks.docs[0].id);
    String docId = tasks.docs[0].id;
    await db.collection("tasks").doc(docId).update({"status": value});
  }

  @override
  Future<List<Nurse>> getNurses() async {

    QuerySnapshot nurses = await db.collection("users").get();
    List<Nurse> listOfNurses = nurses.docs.map((e) => Nurse(
      name: e["name"],
      id: e["id"],
    )).toList();
    return listOfNurses;

  }

  @override
  Future<List<Resident>> getResidents() async {

    QuerySnapshot residents = await db.collection("residents").get();
    List<Resident> listOfResidents = residents.docs.map((e) => Resident(
        name: e["name"],
        id: e["id"],
    )).toList();
    return listOfResidents;

  }

  @override
  Future<List<Shift>> getShifts() async {
    QuerySnapshot shifts = await db.collection("shifts").get();
    List<Shift> listOfShifts= shifts.docs.map((e) => Shift(
        name: e["name"],
        id: e["id"],
        startTime: e["startTime"],
        stopTime: e["stopTime"]
    )).toList();
    return listOfShifts;
  }

  @override
  Future<List<Task>> getTasks() async {
    QuerySnapshot tasks = await db.collection("tasks").get();
    List<Task> listOfTasks = tasks.docs.map((e) => Task(
        note: e["note"],
        user: e["user"],
        resident: e["resident"],
        id: e["id"],
        shiftStartTime: e["shiftStartTime"],
        shiftStopTime: e["shiftStopTime"],
        status: e["status"],
    )).toList();
    return listOfTasks;
  }



}