import 'package:bloc/bloc.dart';
import 'package:dexter_todo/core/repository/app_repository.dart';
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

}
