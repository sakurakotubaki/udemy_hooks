import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
      home: const UseStreamExample(),
    );
  }
}

class UseStreamExample extends HookWidget {
  const UseStreamExample({super.key});

  @override
  Widget build(BuildContext context) {
    // useMemoizedで、1秒ごとに整数を発行するStreamを作成
    final stream = useMemoized(
      () => Stream<int>.periodic(const Duration(seconds: 1), (x) => x),
      [],
    );

    return Scaffold(
      appBar: AppBar(title: Text('UseEffect Example')),
      // HookBuilderを使用して、Hookを使ったWidgetを作成
      body: HookBuilder(
        builder: (context) {
          // useStreamで、Streamの値を監視
          final snapshot = useStream(stream);

          // スナップショットのデータがある場合はその値を表示
          return Center(
            child: Text(
              snapshot.hasData
                  ? 'Current value: ${snapshot.data}'
                  : 'Waiting for data...',
              style: TextStyle(fontSize: 24),
            ),
          );
        },
      ),
    );
  }
}
