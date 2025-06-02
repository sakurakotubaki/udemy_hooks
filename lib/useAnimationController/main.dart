import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RotationSun());
  }
}

// class RotationSun extends StatefulWidget {
//   const RotationSun({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _RotationSunState createState() => _RotationSunState();
// }

// class _RotationSunState extends State<RotationSun>
//     with SingleTickerProviderStateMixin {
//   // _controllerの役割は、アニメーションの時間を管理することです。
//   late AnimationController _controller;
//   // double型の値をアニメーションさせるために、Animation<double>を使用します。
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     // AnimationControllerのインスタンスを作成します。
//     _controller = AnimationController(
//       duration: const Duration(seconds: 5),
//       vsync: this,
//     )..repeat(); // AnimationControllerのrepeat()メソッドを呼び出すことで、アニメーションを繰り返すことができます。
//     // Tweenクラスのbeginとendには、アニメーションの開始値と終了値を指定します。
//     _animation =
//         Tween(begin: 0.0, end: 2 * 3.14159265358979323846).animate(_controller)
//           ..addListener(() {
//             setState(() {});
//           });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Rotating Sun')),
//       body: Center(
//         // Transform.rotate()ウィジェットを使用して、アニメーションを実装します。
//         child: Transform.rotate(
//           angle: _animation.value,
//           child: Icon(Icons.wb_sunny, size: 100.0, color: Colors.orange),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // アニメーションが不要になったときには、dispose()メソッドを呼び出して破棄します。
//     _controller.dispose();
//     super.dispose();
//   }
// }

// FlutterHooksの場合
class RotationSun extends HookWidget {
  const RotationSun({super.key});

  @override
  Widget build(BuildContext context) {
    // 内部実装のuseSingleTickerProvider()を使用して、TickerProviderを取得します。
    final controller = useAnimationController(
      duration: const Duration(seconds: 5),
    )..repeat(); // AnimationControllerのrepeat()メソッドを呼び出すことで、アニメーションを繰り返すことができます。
    // Tweenクラスのbeginとendには、アニメーションの開始値と終了値を指定します。
    final animation = useAnimation(
      Tween<double>(
        begin: 0.0,
        end: 2 * 3.14159265358979323846,
      ).animate(controller),
    );
    // Transform.rotate()ウィジェットを使用して、アニメーションを実装します。
    return Scaffold(
      appBar: AppBar(title: const Text('useAnimationController')),
      body: Center(
        // Transform.rotate()ウィジェットを使用して、アニメーションを実装します。
        child: Transform.rotate(
          angle: animation,
          child: const Icon(Icons.wb_sunny, size: 100.0, color: Colors.orange),
        ),
      ),
    );
  }
}
