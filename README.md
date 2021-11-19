# Testing Riverpod StateNotifierProvider

An example of how to mock state for testing widgets when using riverpod StateNotifierProvider.

**These tests work without Mocktail / Mockito**

**Quick Details**

- Model: Counter class created with Freezed
- State: CounterNotifier extends StateNotifier
- Provider: counterProvider is a StateNotifierProvider

## Important For Testability of StateNotifierProvider

When testing Flutter widgets, one may want to mock a predefined state in order to test how widgets render for a given state. For example, a widget may need to show or hide depending on user role, which could be part of a user object stored in state. Our test allows us to ensure this important conditional rendering does not break with future code changes.

In this simplified example, we are using a counter to test whether a widget renders when the count is even.

This repository exists as an example for how to architect your `StateNotifier` and its constructor such that a mocked provider and predefined state can be used by the test widget.

Below is a breakdown of what is happening in this repository.

### Explanation

**The Test Widget**

```dart
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
```

This test widget for our home screen uses the `overrides` property of `ProviderScope()` in order to override the provider used in the widget.

When the home.dart `ScreenHome()` widget calls `Counter counter = ref.watch(counterProvider);` it will use our `mockProvider` instead of the "real" provider.

The `isEvenTestWidget()` mockProvider argument is the same "type" of provider as `counterProvider()`.

**The Test**

```dart
testWidgets('If count is even, IsEvenMessage is rendered.', (tester) async {
  // Mock a provider with an even count
  final mockCounterProvider =
      StateNotifierProvider<CounterNotifier, Counter>((ref) => CounterNotifier(counter: const Counter(count: 2)));

  await tester.pumpWidget(isEvenTestWidget(mockCounterProvider));

  expect(find.byType(IsEvenMessage), findsOneWidget);
});
```

In the test, we create a mockProvider with predefined values that we need for testing `ScreenHome()` widget rendering. In this example, our provider is initialized with the **state** `count: 2`.

We are testing that the `isEvenMessage()` widget is rendered with an even count (of 2). Another test tests that the widget is not rendered with an odd count.

**StateNotifier Constructor**

```dart
class CounterNotifier extends StateNotifier<Counter> {
  CounterNotifier({Counter counter = const Counter(count: 0)}) : super(counter);

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }
}
```

In order to be able to create a mockProvider with a predefined state, it is important that the StateNotifier (`counter_state.dart`) constructor includes an optional parameter of the state model. The **default argument** is how the state should normally initialize. Our tests can **optionally** provide a specified state for testing which is passed to `super()`.

---

## Build Runner

Code generator is required for freezed class code generation

```
$ flutter pub run build_runner build --delete-conflicting-outputs
```
