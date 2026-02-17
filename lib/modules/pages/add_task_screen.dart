import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_first_app/models/task_entity_model.dart';
import 'package:my_first_app/providers/task_notifier.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<AddTaskScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(taskNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text('Add Task'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please write a title';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Title'),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: descController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please write a description';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Description'),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    notifier.addTask(
                      TaskEntityModel(
                        id: DateTime.now().toIso8601String(),
                        title: titleController.text.trim(),
                        description: descController.text.trim(),
                        isCompleted: false,
                        createdAt: DateTime.now(),
                      ),
                    );
                    context.pop();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
