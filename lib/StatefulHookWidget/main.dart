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

class MyHomePage extends StatefulHookWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// setStateでcheckboxの状態を管理する。
  /// useXXXは、buildメソッドの中でのみ使用できる。State classのフィールドとしては使用できない。
  bool _checked = false;

  void _toggleCheckbox() {
    setState(() {
      _checked = !_checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    // useStateを使用してcheckboxの状態を管理する。
    final checkState = useState<bool>(false);

    /// checkbox用のuseCallbackを定義する。
    // [useCallback]は、関数をメモ化して、再ビルド時に同じ関数を再利用するために使用する。
    /// これにより、パフォーマンスが向上し、無駄な再ビルドを防ぐことができる。
    /// useCallbackは、[useState]や[useEffect]と同様に、buildメソッドの中でのみ使用できる。
    final toggleCheckbox = useCallback(() {
      checkState.value = !checkState.value;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('Hooks Widget')),
      body: Center(
        child: Column(
          spacing: 10.0, // children: ないで余白を10.0開ける。
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Checkbox: ${checkState.value ? 'Checked' : 'Unchecked'}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () => toggleCheckbox(),
              child: const Text('useState'),
            ),
            // setStateを使ったカウンター
            Text(
              'setState: ${_checked ? 'Checked' : 'Unchecked'}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () => _toggleCheckbox(),
              child: const Text('setState'),
            ),
          ],
        ),
      ),
    );
  }
}
