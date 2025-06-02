import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const UseReducerExample());
  }
}

// useReducer用のUnion Type - Action
sealed class CounterAction {
  const CounterAction();
}

class Increment extends CounterAction {
  final int amount;
  const Increment([this.amount = 1]);
}

class Decrement extends CounterAction {
  final int amount;
  const Decrement([this.amount = 1]);
}

class Reset extends CounterAction {
  const Reset();
}

class SetValue extends CounterAction {
  final int value;
  const SetValue(this.value);
}

class InitialCounter extends CounterAction {
  const InitialCounter();
}

// Counter State
class CounterState {
  final int value;
  final int history;

  const CounterState({required this.value, required this.history});

  CounterState copyWith({int? value, int? history}) {
    return CounterState(
      value: value ?? this.value,
      history: history ?? this.history,
    );
  }
}

// Counter Reducer
CounterState counterReducer(CounterState state, CounterAction action) {
  return switch (action) {
    Increment(:final amount) => state.copyWith(
      value: state.value + amount,
      history: state.history + 1,
    ),
    Decrement(:final amount) => state.copyWith(
      value: state.value - amount,
      history: state.history + 1,
    ),
    Reset() => state.copyWith(value: 0, history: state.history + 1),
    SetValue(:final value) => state.copyWith(
      value: value,
      history: state.history + 1,
    ),
    InitialCounter() => const CounterState(value: 0, history: 0),
  };
}

// Todo用のUnion Type
sealed class TodoAction {
  const TodoAction();
}

class AddTodo extends TodoAction {
  final String text;
  const AddTodo(this.text);
}

class ToggleTodo extends TodoAction {
  final int id;
  const ToggleTodo(this.id);
}

class RemoveTodo extends TodoAction {
  final int id;
  const RemoveTodo(this.id);
}

class UpdateTodo extends TodoAction {
  final int id;
  final String text;
  const UpdateTodo(this.id, this.text);
}

class ClearCompleted extends TodoAction {
  const ClearCompleted();
}

// Todo Model
class Todo {
  final int id;
  final String text;
  final bool isCompleted;

  const Todo({required this.id, required this.text, this.isCompleted = false});

  Todo copyWith({int? id, String? text, bool? isCompleted}) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

// Todo State
class TodoState {
  final List<Todo> todos;
  final int nextId;

  const TodoState({required this.todos, required this.nextId});

  TodoState copyWith({List<Todo>? todos, int? nextId}) {
    return TodoState(todos: todos ?? this.todos, nextId: nextId ?? this.nextId);
  }
}

// Todo Reducer
TodoState todoReducer(TodoState state, TodoAction action) {
  return switch (action) {
    AddTodo(:final text) => state.copyWith(
      todos: [
        ...state.todos,
        Todo(id: state.nextId, text: text),
      ],
      nextId: state.nextId + 1,
    ),
    ToggleTodo(:final id) => state.copyWith(
      todos: state.todos
          .map(
            (todo) => todo.id == id
                ? todo.copyWith(isCompleted: !todo.isCompleted)
                : todo,
          )
          .toList(),
    ),
    RemoveTodo(:final id) => state.copyWith(
      todos: state.todos.where((todo) => todo.id != id).toList(),
    ),
    UpdateTodo(:final id, :final text) => state.copyWith(
      todos: state.todos
          .map((todo) => todo.id == id ? todo.copyWith(text: text) : todo)
          .toList(),
    ),
    ClearCompleted() => state.copyWith(
      todos: state.todos.where((todo) => !todo.isCompleted).toList(),
    ),
  };
}

// useReducerの使用例
class UseReducerExample extends HookWidget {
  const UseReducerExample({super.key});

  @override
  Widget build(BuildContext context) {
    // カウンター用のuseReducer
    final counterState = useReducer<CounterState, CounterAction>(
      counterReducer,
      initialState: const CounterState(value: 0, history: 0),
      initialAction: const InitialCounter(),
    );

    // Todo用のuseReducer
    final todoState = useReducer<TodoState, TodoAction>(
      todoReducer,
      initialState: const TodoState(todos: [], nextId: 1),
      initialAction: const ClearCompleted(),
    );

    // テキストコントローラー
    final todoController = useTextEditingController();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('UseReducer Example'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.calculate), text: 'Counter'),
              Tab(icon: Icon(Icons.checklist), text: 'Todo'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // カウンタータブ
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const Text(
                            'カウンター',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${counterState.state.value}',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '操作回数: ${counterState.state.history}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // カウンターボタン
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () =>
                            counterState.dispatch(const Increment()),
                        icon: const Icon(Icons.add),
                        label: const Text('+1'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () =>
                            counterState.dispatch(const Increment(5)),
                        icon: const Icon(Icons.add),
                        label: const Text('+5'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () =>
                            counterState.dispatch(const Decrement()),
                        icon: const Icon(Icons.remove),
                        label: const Text('-1'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () =>
                            counterState.dispatch(const Decrement(5)),
                        icon: const Icon(Icons.remove),
                        label: const Text('-5'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => counterState.dispatch(const Reset()),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Todoタブ
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Todo追加フィールド
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: todoController,
                          decoration: const InputDecoration(
                            labelText: '新しいTodo',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.add_task),
                          ),
                          onSubmitted: (text) {
                            if (text.trim().isNotEmpty) {
                              todoState.dispatch(AddTodo(text.trim()));
                              todoController.clear();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          final text = todoController.text.trim();
                          if (text.isNotEmpty) {
                            todoState.dispatch(AddTodo(text));
                            todoController.clear();
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('追加'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 統計情報
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                '${todoState.state.todos.length}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('総数'),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '${todoState.state.todos.where((todo) => todo.isCompleted).length}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const Text('完了'),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '${todoState.state.todos.where((todo) => !todo.isCompleted).length}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                              const Text('未完了'),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed:
                                todoState.state.todos.any(
                                  (todo) => todo.isCompleted,
                                )
                                ? () =>
                                      todoState.dispatch(const ClearCompleted())
                                : null,
                            icon: const Icon(Icons.clear_all),
                            label: const Text('完了削除'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Todoリスト
                  Expanded(
                    child: todoState.state.todos.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.checklist,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Todoがありません\n上記のフィールドから追加してください',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: todoState.state.todos.length,
                            itemBuilder: (context, index) {
                              final todo = todoState.state.todos[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: Checkbox(
                                    value: todo.isCompleted,
                                    onChanged: (_) =>
                                        todoState.dispatch(ToggleTodo(todo.id)),
                                  ),
                                  title: Text(
                                    todo.text,
                                    style: TextStyle(
                                      decoration: todo.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: todo.isCompleted
                                          ? Colors.grey
                                          : null,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        todoState.dispatch(RemoveTodo(todo.id)),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
