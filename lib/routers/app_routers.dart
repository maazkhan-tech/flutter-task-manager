import 'package:go_router/go_router.dart';
import 'package:my_first_app/modules/pages/add_task_screen.dart';
import 'package:my_first_app/routers/app_routes.dart';
import 'package:my_first_app/shared/pages/home_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: AppRoutes.addTask,
      path: '/${AppRoutes.addTask}',
      builder: (context, state) => AddTaskScreen(),
    ),
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
  ],
);
