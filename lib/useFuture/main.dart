import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:udemy_hooks/useFuture/user_datasource.dart';
import 'package:udemy_hooks/useFuture/user_model.dart';

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
      home: const UseFutureExample(),
    );
  }
}

sealed class AsyncValue<T> {
  const AsyncValue();
}

class AsyncLoading<T> extends AsyncValue<T> {
  const AsyncLoading();
}

class AsyncData<T> extends AsyncValue<T> {
  final T value;
  const AsyncData(this.value);
}

class AsyncError<T> extends AsyncValue<T> {
  final Object error;
  const AsyncError(this.error);
}

class UseFutureExample extends HookWidget {
  const UseFutureExample({super.key});

  // AsyncSnapshotをAsyncValueに変換するヘルパー関数
  AsyncValue<List<UserModel>> _convertToAsyncValue(
    AsyncSnapshot<List<UserModel>> snapshot,
  ) {
    return switch (snapshot.connectionState) {
      ConnectionState.waiting || ConnectionState.active => const AsyncLoading(),
      ConnectionState.done =>
        snapshot.hasError
            ? AsyncError(snapshot.error!)
            : AsyncData(snapshot.data ?? []),
      ConnectionState.none => const AsyncError('No connection'),
    };
  }

  @override
  Widget build(BuildContext context) {
    final userDataSource = UserDataSource();
    return Scaffold(
      appBar: AppBar(title: const Text('UseFuture')),
      body: HookBuilder(
        builder: (context) {
          final snapshot = useFuture(
            useMemoized(() => userDataSource.getUser(), []),
          );

          final asyncValue = _convertToAsyncValue(snapshot);

          return Center(
            child: switch (asyncValue) {
              AsyncLoading() => const CircularProgressIndicator(),
              AsyncError(:final error) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              AsyncData(:final value) when value.isEmpty => const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 48, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No users found'),
                ],
              ),
              AsyncData(:final value) => ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final user = value[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text('${user.id}')),
                    title: Text(user.name),
                    subtitle: Text('ID: ${user.id}'),
                  );
                },
              ),
            },
          );
        },
      ),
    );
  }
}
