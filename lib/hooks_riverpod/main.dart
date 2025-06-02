import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:udemy_hooks/hooks_riverpod/providers/notes_notifier.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hooks Riverpod Todo App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const NoteGeneratePage(),
    );
  }
}

class NoteGeneratePage extends HookConsumerWidget {
  const NoteGeneratePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Riverpodのrefを使用して、NotifierProviderを監視する。
    final noteAppGenerater = ref.watch(notesNotifierProvider);

    /// HookConsumerWidgetの中では、useXXXを使用することができる。
    final bodyController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Hooks Riverpod')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: 16.0,
            children: [
              const SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: bodyController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final body = bodyController.text.trim();
                  if (body.isNotEmpty) {
                    ref.read(notesNotifierProvider.notifier).addNote(body);
                    bodyController.clear(); // 入力フォームをクリアする.
                  }
                },
                child: const Text('Add note'),
              ),
              noteAppGenerater.isEmpty
                  ? const Text('Add notes')
                  : ListView.builder(
                      itemCount: noteAppGenerater.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final note = noteAppGenerater[index];
                        return ListTile(
                          title: Text(
                            'id: $note memo: ${note.body}',
                          ), // idとフォームから入力された値を表示.
                          subtitle: Text(
                            note.createdAt.toIso8601String(),
                          ), // リストにデータを追加した時刻を表示.
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              ref
                                  .read(notesNotifierProvider.notifier)
                                  .removeNote(note.id);
                            },
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
