import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_first_app/database/hive_database.dart';
import 'package:my_first_app/models/task_entity_model.dart';

abstract class TaskRepository {
  List<TaskEntityModel> getAllTasks();
  Future<void> addTask(TaskEntityModel task);
  Future<void> updateTask(TaskEntityModel task);
  Future<void> deletTask(String id);
}

class TaskRepositoryImpl implements TaskRepository {
  final HiveDatabase database;
  TaskRepositoryImpl({required this.database});
  @override
  List<TaskEntityModel> getAllTasks() {
    return database.getAllTasks();
  }

  @override
  Future<void> addTask(TaskEntityModel task) async {
    await database.addTask(task);
  }

  @override
  Future<void> updateTask(TaskEntityModel task) async {
    await database.updateTask(task);
  }

  @override
  Future<void> deletTask(String id) async {
    await database.deleteTask(id);
  }
}

final repositoryProvider = Provider<TaskRepository>((ref) {
  final database = ref.watch(hiveDatabaseProvider);
  return TaskRepositoryImpl(database: database);
});
