import 'package:bloc/bloc.dart';
import 'package:dexter_todo/core/repository/app_repository.dart';
import 'package:dexter_todo/data/models/nurse.dart';
import 'package:dexter_todo/data/models/resident.dart';
import 'package:dexter_todo/data/models/shift.dart';
import 'package:dexter_todo/data/models/task.dart';
import 'package:dexter_todo/helpers/di/dependency.dart';
import 'package:equatable/equatable.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {

  final AppRepository _appRepository = locator<AppRepository>();

  TaskCubit() : super(TaskInitial());

  void createTask(Task task) async {
    emit(TaskLoading());
    _appRepository.createTask(task);
    emit(CreateTaskSuccess());
  }

  void getLists() async {
    List<Nurse> nurses = await _appRepository.getNurses();
    List<Shift> shifts = await _appRepository.getShifts();
    List<Resident> residents = await _appRepository.getResidents();

    emit(GetList(nurses, shifts, residents));
  }

}
