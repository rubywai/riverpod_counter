import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_counter/counter_notifier.dart';

//provider [Object]
//future provider [Future]
//stream provider [Stream]

//change notifier
//state notifier

//notifier
//async notifier
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return Home();
            }));
          },
          child: const Text('Go to Home'),
        ),
      ),
    );
  }
}

//ConsumerWidget
//ConsumerStatefulWidget
class Home extends ConsumerWidget {
  Home({super.key});
  final counterProvider = CounterProvider(() {
    return CounterNotifier();
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(counterProvider, (previous, next) {
      print('old state is $previous new state is $next');
    });
    int count = ref.watch(counterProvider);
    CounterNotifier counterNotifier = ref.read(counterProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpods'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The counter is $count',
              style: const TextStyle(fontSize: 20),
            ),
            FilledButton(
              onPressed: () {
                counterNotifier.increment();
              },
              child: const Text('+'),
            ),
            FilledButton(
              onPressed: () {
                counterNotifier.decrement();
              },
              child: const Text('-'),
            ),
            FilledButton(
              onPressed: () {
               int defaultValue = ref.refresh(counterProvider);
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}


