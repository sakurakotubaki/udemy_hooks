import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:udemy_hooks/hooks_riverpod/models/notes_model.dart';
part 'notes_notifier.g.dart';

@riverpod
class NotesNotifier extends _$NotesNotifier {
  // 初期状態を空のリストで設定
  @override
  List<NotesModel> build() {
    return [];
  }

  // Listの状態を更新するためのメソッドを定義
  void addNote(String body) {
    if (body.trim().isEmpty) return;

    final newNote = NotesModel(
      DateTime.now().millisecondsSinceEpoch,
      body,
      DateTime.now(),
    );

    /// [...state]は、Riverpodの状態を更新するためのプロパティ | [newNote]はfreezedに値を保持したものを渡している。
    state = [...state, newNote];
  }

  /// ゴミ箱のボタンを押したときに、指定されたIDのノートを削除するメソッドを定義
  /// state.whereを使用して、指定されたIDのノートを除外する。
  void removeNote(int id) {
    state = state.where((note) => note.id != id).toList();
  }
}
