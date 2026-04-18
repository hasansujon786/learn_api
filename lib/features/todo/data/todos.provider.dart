import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_api/core/api/dio.provider.dart';
import 'package:learn_api/features/todo/data/todos.api.dart';

import '../models/todo.dart';

class GetTodosNotifier extends AsyncNotifier<List<Todo>> {
  @override
  Future<List<Todo>> build() async {
    final api = ref.read(_todosApiProvider);
    return api.getTodos();
  }
}

class CreateTodoNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> call(String title) async {
    state = const AsyncLoading();

    try {
      final api = ref.read(_todosApiProvider);

      await api.createTodo({"title": title, "completed": false, "userId": 1});

      state = const AsyncData(null);

      ref.invalidate(getTodosProvider);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final _todosApiProvider = Provider<TodosApi>((ref) {
  final dio = ref.read(dioProvider);
  return TodosApi(dio);
});
final getTodosProvider = AsyncNotifierProvider<GetTodosNotifier, List<Todo>>(
  GetTodosNotifier.new,
);
final createTodoProvider = AsyncNotifierProvider<CreateTodoNotifier, void>(
  CreateTodoNotifier.new,
);
