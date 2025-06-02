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
      home: const UseEffectExample(),
    );
  }
}

class UseEffectExample extends HookWidget {
  const UseEffectExample({super.key});

  @override
  Widget build(BuildContext context) {
    /// initStateのように使うこともできる。
    useEffect(() {
      debugPrint('useEffect called');
      return () {
        debugPrint('useEffect cleanup called');
      };
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('useEffect')),
      body: Center(child: Text('Check console for useEffect logs')),
    );
  }
}
