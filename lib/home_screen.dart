import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  final _inputFocus = FocusNode();
  bool _inputFocused = false;

  @override
  void initState() {
    super.initState();
    _inputFocus.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _inputFocus.removeListener(_handleFocusChange);
    _inputFocus.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _inputFocused = _inputFocus.hasFocus;
    });
  }

  var idCounter = 0;
  // final List<Todo> _todos;
  final List<Todo> _todos = [
    Todo(id: "1", title: "title1"),
    Todo(id: "2", title: "title2"),
    Todo(id: "3", title: "title3"),
    Todo(id: "4", title: "title4"),
    Todo(id: "4", title: "title4"),
    Todo(id: "4", title: "title4"),
    Todo(id: "4", title: "title4"),
    Todo(id: "4", title: "title4"),
    Todo(id: "4", title: "title4"),
  ];

  void _addTodo() {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    setState(() {
      _todos.add(Todo(id: '${++idCounter}', title: title));
    });
    _controller.clear();
  }

  void _toggleTodo(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index == -1) return;
    setState(() {
      _todos[index] = todo.getTodo(completed: !todo.completed);
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos.removeWhere((t) => t.id == todo.id);
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
                          _buildTodos(
                            theme,
                            _todos,
                          ), // ← satu widget, tanpa spread
                        ],
                      ),
                    ),
                  ),
                  _buildBottomBar(theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTodos(ShadThemeData theme, List<Todo> todos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...todos.map(
          (todo) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _TodoItem(
              todo: todo,
              onToggle: () => _toggleTodo(todo),
              onDelete: () => _deleteTodo(todo),
            ),
          ),
        ),
      ],
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
          Text('For your everyday task', style: theme.textTheme.muted),
        ],
      ),
    );
  }

  Widget _buildBottomBar(ShadThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(child: _buildInputRow(theme)),
          const SizedBox(width: 8),
          ShadButton(
            height: 40,
            onPressed: _addTodo,
            decoration: ShadDecoration(
              border: ShadBorder(radius: BorderRadius.circular(999)),
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildInputRow(ShadThemeData theme) {
    return ShadInput(
      controller: _controller,
      focusNode: _inputFocus,
      placeholder: const Text('Add a task...'),
      leading: const Icon(LucideIcons.plus, size: 16),
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => _addTodo(),
      onPressedOutside: (_) => _inputFocus.unfocus(),
      decoration: ShadDecoration(
        disableSecondaryBorder: true,
        color: theme.colorScheme.input,
        border: ShadBorder.all(
          radius: BorderRadius.circular(999),
          color: theme.colorScheme.border,
          width: 1,
        ),
        focusedBorder: ShadBorder.all(
          radius: BorderRadius.circular(999),
          color: theme.colorScheme.border,
          width: 1,
        ),
        shadows: _inputFocused ? ShadShadows.lg : null,
      ),
    );
  }
}

class _TodoItem extends StatelessWidget {
  const _TodoItem({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

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
          ShadIconButton.ghost(
            onPressed: onDelete,
            icon: const Icon(LucideIcons.trash2, size: 16),
          ),
        ],
      ),
    );
  }
}
