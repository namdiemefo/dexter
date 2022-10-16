part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {
  @override
  List<Object> get props => [];
}

class GetList extends TaskState {

  final List<Nurse> nurses;
  final List<Shift> shifts;
  final List<Resident> residents;

  GetList(this.nurses, this.shifts, this.residents);

  @override
  List<Object> get props => [nurses, shifts, residents];
}

class CreateTaskSuccess extends TaskState {
  @override
  List<Object> get props => [];
}

class CreateTaskFailure extends TaskState {
  @override
  List<Object> get props => [];
}
