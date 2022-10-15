import 'package:bloc/bloc.dart';
import 'package:dexter_todo/core/repository/app_repository.dart';
import 'package:dexter_todo/data/models/shift.dart';
import 'package:dexter_todo/data/models/task.dart';
import 'package:dexter_todo/helpers/di/dependency.dart';
import 'package:equatable/equatable.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {

  final AppRepository _appRepository = locator<AppRepository>();

  TodoCubit() : super(TodoInitial());


  void markTask(bool value, String id) async {
    emit(TodoLoading());
    _appRepository.markTask(value, id);
  }

  void getTasks() async {
    emit(TodoLoading());
    List<Task> tasks = await _appRepository.getTasks();
    emit(TodoList(tasks));
  }

  void filterTasks(num startTime, num stopTime) async {
    List<Task> tasks = await _appRepository.getTasks();
    tasks.removeWhere((element) => element.shiftStartTime < startTime && element.shiftStartTime > startTime);
    emit(TodoList(tasks));
  }

  void getShifts() async {
    List<Shift> shifts = await _appRepository.getShifts();
    emit(ShiftList(shifts));
  }

}
