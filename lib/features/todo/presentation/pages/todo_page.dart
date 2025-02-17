import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ca2/features/todo/domain/entities/todo.dart';
import 'package:flutter_ca2/features/todo/presentation/bloc/todo_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F3),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Tasks",
          style: TextStyle(
            color: Color(0xFF2F3437),
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTodo(context),
        backgroundColor: const Color(0xFF2F3437),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2F3437),
              ),
            );
          }

          if (state is ErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Color(0xFFE03E3E),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(
                      color: Color(0xFFE03E3E),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is SuccessState) {
            return state.data.isEmpty
                ? _buildEmptyState()
                : _buildTodoList(state.data);
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_add_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks yet',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Click + to add a new task',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList(List<Todo> todos) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              context.read<TodoBloc>().add(
                    UpdateTodoEvent(
                      id: todo.id,
                      isChecked: !todo.isChecked,
                    ),
                  );
            },
            leading: Icon(
              todo.isChecked
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              color: todo.isChecked ? const Color(0xFF37352F) : Colors.grey,
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF37352F),
                decoration: todo.isChecked ? TextDecoration.lineThrough : null,
                decorationColor: Colors.black54,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF37352F),
                  ),
                  onPressed: () => _updateTodo(context, todo),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFE03E3E),
                  ),
                  onPressed: () => _showDeleteConfirmation(context, todo),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Task',
          style: TextStyle(color: Color(0xFF37352F)),
        ),
        content: Text(
          'Are you sure you want to delete "${todo.title}"?',
          style: const TextStyle(color: Color(0xFF37352F)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF37352F)),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<TodoBloc>().add(DeleteTodoEvent(id: todo.id));
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFE03E3E),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showTodoDialog({
    required BuildContext context,
    required String title,
    required String buttonText,
    required Function(String) onSubmit,
    String initialText = '',
  }) {
    _controller.text = initialText;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF37352F),
            fontWeight: FontWeight.w600,
          ),
        ),
        content: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Type your task here...',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE6E6E6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF37352F)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _controller.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF37352F)),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                onSubmit(_controller.text);
                _controller.clear();
                Navigator.pop(context);
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF37352F),
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  void _addTodo(BuildContext context) {
    _showTodoDialog(
      context: context,
      title: 'New Task',
      buttonText: 'Add',
      onSubmit: (text) {
        context.read<TodoBloc>().add(AddTodoEvent(title: text));
      },
    );
  }

  void _updateTodo(BuildContext context, Todo todo) {
    _showTodoDialog(
      context: context,
      title: 'Edit Task',
      buttonText: 'Update',
      initialText: todo.title,
      onSubmit: (text) {
        context.read<TodoBloc>().add(UpdateTodoEvent(id: todo.id, title: text));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
