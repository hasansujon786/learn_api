import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_api/features/todo/data/todos.provider.dart';


class TestWidget extends ConsumerWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(getTodosProvider);
    final createState = ref.watch(createTodoProvider);

    return Column(
      children: [
        /// 🔥 Mutation state (RTK style)
        if (createState.isLoading) const CircularProgressIndicator(),

        if (createState.hasError) Text('Create Error: ${createState.error}'),

        ElevatedButton(
          onPressed: () {
            ref.read(createTodoProvider.notifier).call("New Todo");
          },
          child: const Text("Create Todo"),
        ),

        /// 🔍 Query
        Expanded(
          child: todosAsync.when(
            data: (todos) => ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(title: Text(todo.title));
              },
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Get Error: $e'),
          ),
        ),
      ],
    );
  }
}

