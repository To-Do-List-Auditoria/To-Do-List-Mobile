part of 'todo_form_cubit.dart';

sealed class TodoFormState extends Equatable {
  const TodoFormState();

  @override
  List<Object> get props => [];
}

final class FormInitialState extends TodoFormState {
  const FormInitialState();
}

final class FormLoadingState extends TodoFormState {
  const FormLoadingState();
}

final class FormSuccessState extends TodoFormState {
  const FormSuccessState();
}

final class FormErrorState extends TodoFormState {
  const FormErrorState();
}
