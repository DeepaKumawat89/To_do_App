# to_do_app

A small, opinionated Flutter Todo app that demonstrates:

- Local persistence using Hive (typed adapter for Todo objects)
- State management with Provider
- Theme management (light / dark / system) with persistence via SharedPreferences
- Search, filter (all / pending / completed), undo delete, edit, toggle complete
- Clean, modern UI with a custom dialog for creating / editing todos


## Table of contents

- Features
- Requirements
- Quick start
- Android / iOS / Desktop
- Project structure
- Key files
- Development notes
- Running tests
- Troubleshooting


## Features

- Create, edit, delete Todo items
- Mark todos as completed / pending
- Search and filter todos (All / Pending / Completed)
- Undo last deleted todo
- Persisted storage using Hive
- Theme selection: Light / Dark / System (saved in SharedPreferences)


## Requirements

- Flutter SDK (>= 3.0, tested with the SDK declared in `pubspec.yaml`)
- Dart SDK (matches Flutter)
- Platforms: Android, iOS (macOS required for iOS builds), Windows/macOS/Linux for desktop builds if desired


## Quick start

1. Install Flutter: https://flutter.dev/docs/get-started/install
2. From the project root run:

```powershell
flutter pub get
```

3. Generate Hive adapters (required when model annotations change):

```powershell
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app on an emulator or connected device:

```powershell
flutter run
```

To run on a specific device, use `flutter devices` and `flutter run -d <deviceId>`.


## Android / iOS / Desktop

- Android: open `android/` in Android Studio or use `flutter run`.
- iOS: open `ios/Runner.xcworkspace` in Xcode (macOS only) or use `flutter run` from terminal on a connected iOS device / simulator.
- Windows / macOS / Linux: enable desktop support in your Flutter SDK and run `flutter run -d windows` (or `macos` / `linux`).


## Project structure

Top-level notable folders/files:

- `lib/`
  - `main.dart` — app entry. Initializes Hive, providers, and theme.
  - `models/todo_model.dart` — Hive-annotated Todo model (run build_runner to generate `todo_model.g.dart`).
  - `providers/` — `todo_provider.dart` (business logic & persistence), `theme_provider.dart` (theme + SharedPreferences).
  - `screens/` — `todo_screen.dart` (main UI screen).
  - `Widgets/` — `add_todo_dialog.dart`, `todo_tile.dart` (reusable UI widgets).
- `pubspec.yaml` — dependencies (hive, provider, hive_flutter, shared_preferences, etc.)


## Key files and notes

- `lib/main.dart`
  - Initializes Hive and registers the `TodoAdapter`.
  - Opens the `todos` box before running the app.
  - Provides `TodoProvider` and `ThemeProvider` with `MultiProvider`.

- `lib/models/todo_model.dart`
  - Annotated with `@HiveType` / `@HiveField`. If you change fields, bump Hive type id/fields carefully and re-run codegen.

- `lib/providers/todo_provider.dart`
  - Handles add/edit/delete/toggle
  - Exposes `filteredTodos` that applies search query and filter type.
  - Keeps a last-deleted item to support `undoDelete()`.

- `lib/providers/theme_provider.dart`
  - Saves theme choice to `SharedPreferences` and loads it on startup.

- `lib/screens/todo_screen.dart`
  - Main UI with header, search, filter dropdown, list, and FAB to add todos.

- `lib/Widgets/add_todo_dialog.dart`
  - Modal dialog for creating / editing tasks with validation.


## Development notes

- Whenever you modify `Todo` model fields run:

```powershell
flutter pub run build_runner build --delete-conflicting-outputs
```

- The app uses Hive boxes. If you need to reset local data during development, uninstall the app from the device or clear the app storage (Android) or delete the Hive box files in the app's documents directory.

- If you add new packages, run `flutter pub get` and update imports as necessary.


## Running tests

This project has the default `flutter_test` dev dependency. To run widget/unit tests (if you add any):

```powershell
flutter test
```


## Troubleshooting

- Build fails because Hive adapter not found: run the build_runner command above to generate `todo_model.g.dart`.
- SharedPreferences issues on first run: ensure the `ThemeProvider` finishes loading before the UI that depends on it. The provider currently loads in its constructor asynchronously; this is expected and the UI reacts when the value is available.


## Contributing

Contributions are welcome. Suggested improvements:

- Add unit & widget tests for providers and screens
- Add undo snackbar when deleting a todo
- Add due dates / reminders
- Add categories and sorting


## License

This project currently has no license file. Add one if you plan to publish or share the project.
