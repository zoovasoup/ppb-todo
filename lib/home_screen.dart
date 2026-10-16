import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'todo.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  final _inputFocus = FocusNode();
  var idCounter = 0;
  // final List<Todo> _todos;
  final List<Todo> _todos = [
    Todo(id: "1", title: "title1"),
    Todo(id: "2", title: "title2"),
    Todo(id: "3", title: "title3"),
    Todo(id: "4", title: "title4"),
  ];

  void _toggleTodo(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index == -1) return;
    setState(() {
      _todos[index] = todo.getTodo(completed: !todo.completed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(theme),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._todos.map(
                            (todo) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: _TodoItem(
                                todo: todo,
                                onToggle: () => _toggleTodo(todo),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ShadThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Todo',
            style: theme.textTheme.h2.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('For your everyday need', style: theme.textTheme.muted),
        ],
      ),
    );
  }

  Widget _buildInput(ShadThemeData theme) {
    return Row(children: [ShadInput()]);
  }
}

class _TodoItem extends StatelessWidget {
  const _TodoItem({required this.todo, required this.onToggle});

  final Todo todo;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ShadCheckbox(value: todo.completed, onChanged: (_) => onToggle()),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              todo.title,
              style: theme.textTheme.p.copyWith(
                color: todo.completed
                    ? theme.colorScheme.mutedForeground
                    : theme.colorScheme.foreground,
                decoration: todo.completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: theme.colorScheme.mutedForeground,
              ),
            ),
          ),
          ShadIconButton.ghost(icon: const Icon(LucideIcons.trash2, size: 16)),
        ],
      ),
    );
  }
}
