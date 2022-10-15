import 'package:dexter_todo/data/models/nurse.dart';
import 'package:dexter_todo/data/models/resident.dart';
import 'package:dexter_todo/data/models/shift.dart';
import 'package:dexter_todo/data/models/task.dart';

abstract class AppRepositoryInterface {

  createTask(Task task);

  markTask(bool value, String id);

  Future<List<Task>> getTasks();

  Future<List<Nurse>> getNurses();

  Future<List<Shift>> getShifts();

  Future<List<Resident>> getResidents();

}