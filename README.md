# udemy_hooks
作成日: 2025/06/02 MON

## 概要
flutter_hooksを使った学習

- 開発環境
  - Flutter 3.32.1
  - Dart 3.8.1

- 使用するパッケージ
  - flutter_hooks
  - hooks_riverpod
  - freezed
  - json_serializable
  - build_runner
  - dio

**add package**

- flutter_hooks
```sh
flutter pub add flutter_hooks
```

- dio
```sh
flutter pub add dio
```

- hooks_riverpod
```sh
flutter pub add \
hooks_riverpod \
riverpod_annotation \
dev:riverpod_generator \
dev:build_runner \
dev:custom_lint \
dev:riverpod_lint
```

- freezed
```sh
flutter pub add \
  freezed_annotation \
  --dev build_runner \
  --dev freezed \
  json_annotation \
  --dev json_serializable
```

自動生成のコマンド
```sh
flutter pub run build_runner watch --delete-conflicting-outputs
```