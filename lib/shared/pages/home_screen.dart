import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/providers/task_notifier.dart';
import 'package:my_first_app/routers/app_routes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskNotifierProvider);
    final notifier = ref.read(taskNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text('TaskMate'), centerTitle: true),
      body: state.when(
        data: (data) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final task = data[index];
                    return Card(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) =>
                                notifier.toggleTaskStatus(task.id),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(task.title),
                                Text(task.description),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => notifier.deleteTask(task.id),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRoutes.addTask);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
