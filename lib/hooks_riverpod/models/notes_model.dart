import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes_model.freezed.dart';

/// freezed 3.0.0 以降は、`part 'notes_model.g.dart';` は不要になりました。
/// 空のプライベートコンストラクタを定義
/// REST APIのモデルを定義する場合は従来と同じ書き方が必要！
@freezed
abstract class NotesModel with _$NotesModel {
  const NotesModel._();

  const factory NotesModel(int id, String body, DateTime createdAt) =
      _NotesModel;
}
