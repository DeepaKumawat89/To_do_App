// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../Widgets/add_todo_dialog.dart';
// import '../Widgets/todo_tile.dart';
// import '../providers/todo_provider.dart';
// import '../providers/theme_provider.dart';
//
// class TodoScreen extends StatelessWidget {
//   const TodoScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final todoProvider = Provider.of<TodoProvider>(context);
//     final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     final now = DateTime.now();
//     final months = [
//       'Jan','Feb','Mar','Apr','May','Jun',
//       'Jul','Aug','Sep','Oct','Nov','Dec'
//     ];
//     final dateStr = '${months[now.month - 1]} ${now.day}, ${now.year}';
//     final taskCount = todoProvider.todos.length;
//
//     return Scaffold(
//       backgroundColor: colorScheme.primary,
//       body: Column(
//         children: [
//
//           // ================= HEADER =================
//           SafeArea(
//             bottom: false,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.grid_view_rounded,
//                           color: colorScheme.onPrimary,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: themeProvider.toggleTheme,
//                         child: Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(30),
//                             border: Border.all(
//                               color: Colors.white.withOpacity(0.25),
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.15),
//                                 blurRadius: 10,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: AnimatedSwitcher(
//                             duration: const Duration(milliseconds: 300),
//                             transitionBuilder: (child, animation) =>
//                                 RotationTransition(
//                                   turns: animation,
//                                   child: FadeTransition(opacity: animation, child: child),
//                                 ),
//                             child: Icon(
//                               themeProvider.isDarkMode
//                                   ? Icons.dark_mode_rounded
//                                   : Icons.light_mode_rounded,
//                               key: ValueKey(themeProvider.isDarkMode),
//                               color: colorScheme.onPrimary,
//                               size: 22,
//                             ),
//                           ),
//                         ),
//                       ),
//
//
//                     ],
//                   ),
//                   const SizedBox(height: 32),
//                   Text(
//                     'My Tasks',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.w800,
//                       color: colorScheme.onPrimary,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '$dateStr  •  $taskCount Tasks',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: colorScheme.onPrimary.withOpacity(0.8),
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                 ],
//               ),
//             ),
//           ),
//
//           // ================= CURVED CONTAINER =================
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: colorScheme.surface,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 20,
//                     offset: const Offset(0, -5),
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//                 child: Column(
//                   children: [
//
//                     // ================= SEARCH + FILTER =================
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
//                       child: Row(
//                         children: [
//
//                           // SEARCH FIELD
//                           Expanded(
//                             child: Container(
//                               height: 45,
//                               padding: const EdgeInsets.symmetric(horizontal: 12),
//                               decoration: BoxDecoration(
//                                 color: theme.cardColor,
//                                 borderRadius: BorderRadius.circular(30),
//                                 border: Border.all(
//                                   color: colorScheme.outline.withOpacity(0.1),
//                                 ),
//                               ),
//                               child: TextField  (
//                                 decoration: const InputDecoration(
//                                   hintText: "Search tasks...",
//                                   border: InputBorder.none,
//                                   prefixIcon: Icon(Icons.search),
//                                 ),
//                                 onChanged: todoProvider.search,
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(width: 12),
//
//                           // FILTER DROPDOWN
//                           Container(
//                             height: 45,
//                             width: 120,
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             decoration: BoxDecoration(
//                               color: theme.cardColor,
//                               borderRadius: BorderRadius.circular(30),
//                               border: Border.all(
//                                 color: colorScheme.outline.withOpacity(0.1),
//                               ),
//                             ),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton<FilterType>(
//                                 value: todoProvider.currentFilter,
//
//                                 // 🔽 Smaller icon
//                                 icon: const Icon(
//                                   Icons.filter_list,
//                                   size: 18,
//                                 ),
//
//                                 // 🔽 Smaller selected text
//                                 style: Theme.of(context).textTheme.bodySmall,
//
//                                 // 🔽 Compact dropdown height
//                                 isDense: true,
//
//                                 onChanged: (value) {
//                                   if (value != null) {
//                                     todoProvider.setFilter(value);
//                                   }
//                                 },
//                                 items: const [
//                                   DropdownMenuItem(
//                                     value: FilterType.all,
//                                     child: Text(
//                                       "All",
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                   ),
//                                   DropdownMenuItem(
//                                     value: FilterType.pending,
//                                     child: Text(
//                                       "Pending",
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                   ),
//                                   DropdownMenuItem(
//                                     value: FilterType.completed,
//                                     child: Text(
//                                       "Completed",
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//
//               ],
//                       ),
//                     ),
//
//                     // ================= TODO LIST =================
//                     Expanded(
//                       child: todoProvider.filteredTodos.isEmpty
//                           ? _buildModernEmptyState(context)
//                           : ListView.builder(
//                         padding: const EdgeInsets.only(
//                           top: 12,
//                           left: 20,
//                           right: 20,
//                           bottom: 100,
//                         ),
//                         itemCount: todoProvider.filteredTodos.length,
//                         itemBuilder: (context, index) {
//                           final todo =
//                           todoProvider.filteredTodos[index];
//                           return Container(
//                             margin:
//                             const EdgeInsets.only(bottom: 16),
//                             decoration: BoxDecoration(
//                               color: theme.cardColor,
//                               borderRadius:
//                               BorderRadius.circular(20),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: colorScheme.shadow
//                                       .withOpacity(0.05),
//                                   blurRadius: 15,
//                                   offset: const Offset(0, 5),
//                                 ),
//                               ],
//                             ),
//                             child: Theme(
//                               data: theme.copyWith(
//                                 dividerColor:
//                                 Colors.transparent,
//                               ),
//                               child: TodoTile(todo: todo),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       // ================= FAB =================
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (_) => const AddTodoDialog(),
//           );
//         },
//         backgroundColor: colorScheme.primary,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(18),
//         ),
//         child: Icon(Icons.add, color: colorScheme.onPrimary, size: 30),
//       ),
//     );
//   }
//
//   // ================= EMPTY STATE =================
//   Widget _buildModernEmptyState(BuildContext context) {
//     return SingleChildScrollView(
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(40),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.assignment_add,
//                 size: 80,
//                 color: Theme.of(context).disabledColor,
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 "You're all caught up!",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context)
//                       .colorScheme
//                       .onSurface,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 "Create a new task to stay productive.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Theme.of(context)
//                       .colorScheme
//                       .onSurfaceVariant,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Import all required packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/add_todo_dialog.dart';
import '../Widgets/todo_tile.dart';
import '../providers/todo_provider.dart';
import '../providers/theme_provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final now = DateTime.now();
    final months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    final dateStr = '${months[now.month - 1]} ${now.day}, ${now.year}';
    final taskCount = todoProvider.todos.length;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.grid_view_rounded, color: colorScheme.onPrimary),
                      ),
                      GestureDetector(
                        onTap: () => _showThemeSelector(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white.withOpacity(0.25)),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: const Offset(0,4))],
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) =>
                                RotationTransition(turns: animation, child: FadeTransition(opacity: animation, child: child)),
                            child: Icon(
                              themeProvider.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                              key: ValueKey(themeProvider.isDarkMode),
                              color: colorScheme.onPrimary,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text('My Tasks', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: colorScheme.onPrimary)),
                  const SizedBox(height: 8),
                  Text('$dateStr  •  $taskCount Tasks', style: TextStyle(fontSize: 16, color: colorScheme.onPrimary.withOpacity(0.8))),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // Curved container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0,-5))],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                child: Column(
                  children: [
                    // Search + Filter Row
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,24,20,12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 45,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
                              ),
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: "Search tasks...",
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search),
                                ),
                                onChanged: todoProvider.search,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 45,
                            width: 120,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<FilterType>(
                                value: todoProvider.currentFilter,
                                icon: const Icon(Icons.filter_list, size: 18),
                                style: Theme.of(context).textTheme.bodySmall,
                                isDense: true,
                                onChanged: (value) {
                                  if (value != null) todoProvider.setFilter(value);
                                },
                                items: const [
                                  DropdownMenuItem(value: FilterType.all, child: Text("All", style: TextStyle(fontSize: 12))),
                                  DropdownMenuItem(value: FilterType.pending, child: Text("Pending", style: TextStyle(fontSize: 12))),
                                  DropdownMenuItem(value: FilterType.completed, child: Text("Completed", style: TextStyle(fontSize: 12))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Todo List
                    Expanded(
                      child: todoProvider.filteredTodos.isEmpty
                          ? _buildModernEmptyState(context)
                          : ListView.builder(
                        padding: const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 100),
                        itemCount: todoProvider.filteredTodos.length,
                        itemBuilder: (context, index) {
                          final todo = todoProvider.filteredTodos[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [BoxShadow(color: colorScheme.shadow.withOpacity(0.05), blurRadius: 15, offset: const Offset(0,5))],
                            ),
                            child: Theme(
                              data: theme.copyWith(dividerColor: Colors.transparent),
                              child: TodoTile(todo: todo),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => const AddTodoDialog());
        },
        backgroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Icon(Icons.add, color: colorScheme.onPrimary, size: 30),
      ),
    );
  }

  Widget _buildModernEmptyState(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.assignment_add, size: 80, color: Theme.of(context).disabledColor),
              const SizedBox(height: 24),
              Text("You're all caught up!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
              const SizedBox(height: 8),
              Text("Create a new task to stay productive.", textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom sheet theme selector
  void _showThemeSelector(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(leading: const Icon(Icons.settings_brightness), title: const Text("System Default"), onTap: () { themeProvider.setThemeMode(ThemeMode.system); Navigator.pop(context); }),
          ListTile(leading: const Icon(Icons.light_mode), title: const Text("Light"), onTap: () { themeProvider.setThemeMode(ThemeMode.light); Navigator.pop(context); }),
          ListTile(leading: const Icon(Icons.dark_mode), title: const Text("Dark"), onTap: () { themeProvider.setThemeMode(ThemeMode.dark); Navigator.pop(context); }),
        ],
      ),
    );
  }
}
