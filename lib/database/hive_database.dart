import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_first_app/models/task_entity_model.dart';

class HiveDatabase {
  static String box = 'database';
  Box get _box => Hive.box(box);

  // add Task
  Future<void> addTask(TaskEntityModel task) async {
    await _box.put(task.id, task.toJson());
  }

  // update task
  Future<void> updateTask(TaskEntityModel task) async {
    await _box.put(task.id, task.toJson());
  }

  // delete task
  Future<void> deleteTask(String id) async {
    await _box.delete(id);
  }

  List<TaskEntityModel> getAllTasks() {
    return _box.values
        .map((e) => TaskEntityModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}

final hiveDatabaseProvider = Provider<HiveDatabase>((ref) => HiveDatabase());
