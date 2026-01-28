// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import '../models/todo_model.dart';
//
// class TodoProvider extends ChangeNotifier {
//   final Box<Todo> _todoBox = Hive.box<Todo>('todos');
//
//   List<Todo> get todos => _todoBox.values.toList();
//
//   void addTodo(String title) {
//     _todoBox.add(Todo(title: title));
//     notifyListeners();
//   }
//
//   void toggleTodo(Todo todo) {
//     todo.isDone = !todo.isDone;
//     todo.save();
//     notifyListeners();
//   }
//
//   void editTodo(Todo todo, String newTitle) {
//     todo.title = newTitle;
//     todo.save();
//     notifyListeners();
//   }
//
//   void deleteTodo(Todo todo) {
//     todo.delete();
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/todo_model.dart';

enum FilterType { all, pending, completed }

class TodoProvider extends ChangeNotifier {
  final Box<Todo> _todoBox = Hive.box<Todo>('todos');

  FilterType _currentFilter = FilterType.all;
  String _searchQuery = '';

  // ================= GETTERS =================
  List<Todo> get todos => _todoBox.values.toList();

  FilterType get currentFilter => _currentFilter;

  List<Todo> get filteredTodos {
    List<Todo> list = todos;

    // SEARCH
    if (_searchQuery.isNotEmpty) {
      list = list
          .where(
            (todo) => todo.title
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()),
      )
          .toList();
    }

    // FILTER
    if (_currentFilter == FilterType.pending) {
      list = list.where((todo) => !todo.isDone).toList();
    } else if (_currentFilter == FilterType.completed) {
      list = list.where((todo) => todo.isDone).toList();
    }

    return list;
  }

  Todo? _lastDeleted;
  dynamic _lastDeletedKey;


  void deleteTodo(Todo todo) {
    _lastDeleted = todo;
    _lastDeletedKey = todo.key; // 🔑 IMPORTANT

    todo.delete();
    notifyListeners();
  }


  void undoDelete() {
    if (_lastDeleted != null && _lastDeletedKey != null) {
      _todoBox.put(_lastDeletedKey, _lastDeleted!);

      _lastDeleted = null;
      _lastDeletedKey = null;

      notifyListeners();
    }
  }



  // ================= CRUD =================
  void addTodo(String title) {
    _todoBox.add(Todo(title: title));
    notifyListeners();
  }

  void toggleTodo(Todo todo) {
    todo.isDone = !todo.isDone;
    todo.save();
    notifyListeners();
  }

  void editTodo(Todo todo, String newTitle) {
    todo.title = newTitle;
    todo.save();
    notifyListeners();
  }

  // void deleteTodo(Todo todo) {
  //   todo.delete();
  //   notifyListeners();
  // }

  // ================= SEARCH & FILTER =================
  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilter(FilterType filter) {
    _currentFilter = filter;
    notifyListeners();
  }
}

