import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/dogImage.dart'; // 追加

final counterProvider = StateProvider<int>((ref) => 0); // 追加

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Sample',
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => DogImageWidget(),
      },
    );
  }
}

class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    void _incrementCounter() {
      ref.read(counterProvider.notifier).state++;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Counter',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          '$counter',
          style: const TextStyle(fontSize: 48),
        ),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
