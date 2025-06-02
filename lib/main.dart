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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    return Scaffold(
      appBar: AppBar(title: const Text('Hooks Widget')),
      body: Center(
        child: Column(
          spacing: 10.0, // children: 内で余白を10.0開ける。
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${count.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () => count.value++,
              child: const Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () => count.value = 0,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
