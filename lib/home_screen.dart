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
  final List<Todo> _todos = [];

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
                children: [_buildHeader(theme)],
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
