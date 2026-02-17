import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_first_app/models/task_entity_model.dart';
import 'package:my_first_app/repository/task_repository.dart';

class TaskNotifier extends AsyncNotifier<List<TaskEntityModel>> {
  late final TaskRepository repository;

  @override
  FutureOr<List<TaskEntityModel>> build() async {
    repository = ref.watch(repositoryProvider);
    final tasks = repository.getAllTasks();
    return Future.delayed(Duration(seconds: 5), () => tasks);
  }

  get currentTasks => state.value ?? [];

  // add task
  Future<void> addTask(TaskEntityModel task) async {
    try {
      await repository.addTask(task);
      state = AsyncData([...currentTasks, task]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // update task
  Future<void> updateTask(TaskEntityModel updatedTask) async {
    try {
      await repository.updateTask(updatedTask);

      state = AsyncData([
        for (final task in currentTasks)
          if (task.id == updatedTask.id) updatedTask else task,
      ]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // delete task
  Future<void> deleteTask(String id) async {
    try {
      await repository.deletTask(id);

      state = AsyncData(currentTasks.where((task) => task.id != id).toList());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // toggle status
  Future<void> toggleTaskStatus(String id) async {
    final task = currentTasks.firstWhere((task) => task.id == id);

    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);

    await updateTask(updatedTask);
  }
}

final taskNotifierProvider =
    AsyncNotifierProvider<TaskNotifier, List<TaskEntityModel>>(
      TaskNotifier.new,
    );
