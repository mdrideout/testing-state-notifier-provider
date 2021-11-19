import 'package:boilerplatev1/models/counter/counter.dart';
import 'package:boilerplatev1/models/counter/counter_providers.dart';
import 'package:boilerplatev1/models/counter/counter_state.dart';
import 'package:boilerplatev1/screens/home/home.dart';
import 'package:boilerplatev1/screens/home/is_even.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ScreenHome() test widget
  Widget testingWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: ScreenHome(),
      ),
    );
  }

  // ScreenHome() test widget where Riverpod state is overridden with a provided mock provider
  // Hint: isEvenTestWidget Argument is the same type of provider that counterProvider requires
  Widget isEvenTestWidget(StateNotifierProvider<CounterNotifier, Counter> mockProvider) {
    return ProviderScope(
      overrides: [
        counterProvider.overrideWithProvider(mockProvider),
      ],
      child: const MaterialApp(
        home: ScreenHome(),
      ),
    );
  }

  group('Screen functionality tests', () {
    testWidgets('Incrementing the state increments the UI', (tester) async {
      await tester.pumpWidget(testingWidget());

      // Find the default value
      expect(find.text(0.toStringAsFixed(0)), findsOneWidget);
      expect(find.text(1.toStringAsFixed(0)), findsNothing);

      // Increment state and re-render
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Find the values on screen representing updated state
      expect(find.text(0.toStringAsFixed(0)), findsNothing);
      expect(find.text(1.toStringAsFixed(0)), findsOneWidget);
    });
  });

  group('IsEvenMessage widget rendering tests', () {
    testWidgets('If count is even, IsEvenMessage is rendered.', (tester) async {
      // Mock a provider with an even count
      final mockCounterProvider =
          StateNotifierProvider<CounterNotifier, Counter>((ref) => CounterNotifier(counter: const Counter(count: 2)));

      await tester.pumpWidget(isEvenTestWidget(mockCounterProvider));

      expect(find.byType(IsEvenMessage), findsOneWidget);
    });

    testWidgets('If count is odd, IsEvenMessage is not rendered.', (tester) async {
      // Mock a provider with an odd count
      final mockCounterProvider =
          StateNotifierProvider<CounterNotifier, Counter>((ref) => CounterNotifier(counter: const Counter(count: 1)));

      await tester.pumpWidget(isEvenTestWidget(mockCounterProvider));

      expect(find.byType(IsEvenMessage), findsNothing);
    });
  });
}
