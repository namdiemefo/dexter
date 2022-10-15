part of 'todo_cubit.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoList extends TodoState {
  final List<Task> tasks;

  TodoList(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class ShiftList extends TodoState {
  final List<Shift> shifts;

  ShiftList(this.shifts);

  @override
  List<Object> get props => [shifts];
}

class MarkTaskSuccess extends TodoState {
  @override
  List<Object> get props => [];
}

class MarkTaskFailure extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {
  @override
  List<Object> get props => [];
}