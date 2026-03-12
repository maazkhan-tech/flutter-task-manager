# Task Manager App

A clean Flutter task management app built with **Riverpod** state management, **Hive** local storage, and **GoRouter** navigation. Create, complete, and delete tasks — all persisted locally on device with a layered repository architecture.

---

## Features

-  **Add tasks** — Create tasks with a title and description via a dedicated screen
-  **Complete tasks** — Toggle task completion status with a checkbox
-  **Delete tasks** — Remove any task with the delete button
-  **Hive persistence** — All tasks stored locally in a Hive box, survive app restarts
-  **GoRouter navigation** — Named route navigation (`/addtask` → `/`)
-  **Async loading state** — `AsyncNotifier` with loading/error/data states
-  **Form validation** — Title and description required before saving

---

## Tech Stack

| Technology | Usage |
|---|---|
| Flutter | UI Framework |
| Dart | Programming Language |
| `flutter_riverpod` `^3.2.0` | State management (`AsyncNotifier`) |
| `hive` `^2.2.3` | NoSQL key-value local database |
| `hive_flutter` `^1.1.0` | Flutter integration for Hive |
| `go_router` `^17.1.0` | Declarative named-route navigation |

---

## Project Structure

```
lib/
├── main.dart                          # Hive init, ProviderScope, MaterialApp.router
├── models/
│   └── task_entity_model.dart         # TaskEntityModel (fromJson/toJson/copyWith)
├── database/
│   └── hive_database.dart             # Hive CRUD wrapper + hiveDatabaseProvider
├── repository/
│   └── task_repository.dart           # Abstract TaskRepository + TaskRepositoryImpl
├── providers/
│   └── task_notifier.dart             # TaskNotifier (AsyncNotifier) + provider
├── routers/
│   ├── app_routes.dart                # Route name constants
│   └── app_routers.dart               # GoRouter config (/ and /addtask)
├── shared/
│   └── pages/
│       └── home_screen.dart           # Task list with checkbox & delete
└── modules/
    └── pages/
        └── add_task_screen.dart       # Add task form with validation
```

---

## Architecture

This app follows a clean **layered architecture**:

```
UI Layer  (ConsumerWidget / ConsumerStatefulWidget)
      ↓  ref.watch / ref.read
Provider Layer  (AsyncNotifierProvider → TaskNotifier)
      ↓
Repository Layer  (TaskRepository abstract + TaskRepositoryImpl)
      ↓
Data Layer  (HiveDatabase)
      ↓
    Hive Box  (local storage)
```

This separation means the UI never talks to the database directly — the repository acts as a clean interface between business logic and data storage.

---

## Data Model

```dart
class TaskEntityModel {
  final String id;          // DateTime ISO string (unique key)
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;
}
```

Tasks are stored in Hive using `task.id` as the key and `task.toJson()` as the value — making lookups, updates, and deletions fast with O(1) key access.

---

## Navigation Flow

```
HomeScreen (/)
      │
      └── FAB → pushNamed('addtask')
                      ↓
              AddTaskScreen (/addtask)
                      │
                      └── Save → context.pop() → HomeScreen
```

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.9.2`
- Dart SDK `>=3.0.0`
- Android Studio / VS Code with Flutter extension

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/maazkhan-tech/task-manager.git
   cd task-manager
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## Dependencies

```yaml
dependencies:
  flutter_riverpod: ^3.2.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  go_router: ^17.1.0
  cupertino_icons: ^1.0.8
```

---

## What I Learned

- `AsyncNotifier` pattern in Riverpod for managing async state with clean loading/error/data handling
- Repository pattern — abstracting data access behind an interface for testability and clean code
- Hive key-value database — storing, retrieving, updating, and deleting JSON-serialized objects
- `GoRouter` with named routes and `context.pushNamed` / `context.pop` for navigation
- `MaterialApp.router` with a `GoRouter` config instead of standard `MaterialApp`
- `copyWith` pattern on models for immutable state updates
- `AsyncNotifierProvider` and how `build()` replaces the constructor for async initialization

---

## Roadmap

- [ ] Edit existing tasks
- [ ] Due date & time for tasks
- [ ] Priority levels (High / Medium / Low)
- [ ] Filter tasks by status (All / Active / Completed)
- [ ] Swipe to delete gesture

---

## Contributing

Contributions, issues, and feature requests are welcome!
Feel free to open an [issue](https://github.com/maazkhan-tech/task-manager/issues).

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## Author

**Your Name**
- GitHub: [@maazkhan-tech](https://github.com/maazkhan-tech)
- LinkedIn: [Click](https://linkedin.com/in/maaz-khan-5385bb386)
