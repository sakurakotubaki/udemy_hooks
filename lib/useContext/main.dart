import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// カスタムフックを使用して、contextを取得する
// これにより、buildメソッドの外でcontextを使用できるようになります
// 例えば、SnackBarを表示するためのサービスを作成します。
class SnackBarService {
  final BuildContext context;

  SnackBarService(this.context);

  void showSuccess(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

// カスタムフック内でuseContext()を使用
SnackBarService useSnackBar() {
  final context = useContext(); // buildメソッドの外でcontextを取得
  return SnackBarService(context);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const UseContextExample(),
    );
  }
}

class UseContextExample extends HookWidget {
  const UseContextExample({super.key});

  @override
  Widget build(BuildContext context) {
    final snackBar = useSnackBar(); // カスタムフック内でuseContext()を使用

    return Scaffold(
      appBar: AppBar(title: const Text('useContext')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // contextを渡さずに直接使える！
            snackBar.showSuccess('メッセージ');
          },
          child: Text('ボタン'),
        ),
      ),
    );
  }
}
