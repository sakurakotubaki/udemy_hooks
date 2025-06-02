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
      home: const UseRefExample(),
    );
  }
}

class UseRefExample extends HookWidget {
  const UseRefExample({super.key});

  @override
  Widget build(BuildContext context) {
    // ScrollControllerのrefを作成（Reactのuserefに相当）
    final scrollControllerRef = useRef<ScrollController?>(null);

    // 各セクションのキーを管理するためのリスト
    final sectionKeys = useMemoized(
      () => List.generate(10, (index) => GlobalKey()),
    );

    // useEffectでScrollControllerを初期化
    useEffect(() {
      scrollControllerRef.value = ScrollController();
      return () => scrollControllerRef.value?.dispose();
    }, []);

    // 特定のセクションにスクロールする関数
    void scrollToSection(int index) {
      final context = sectionKeys[index].currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('UseRef Auto Scroll'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // ナビゲーションボタン
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    onPressed: () => scrollToSection(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Section ${index + 1}'),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          // スクロール可能なコンテンツ
          Expanded(
            child: ListView.builder(
              controller: scrollControllerRef.value,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  key: sectionKeys[index],
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // h1要素に相当するタイトル
                      Text(
                        'Section ${index + 1}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // コンテンツ
                      Text(
                        'This is the content of section ${index + 1}. '
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // 追加のダミーコンテンツ
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Content Area ${index + 1}',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
