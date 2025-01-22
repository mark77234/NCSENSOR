import 'package:flutter/foundation.dart';

class BaseHook<T> {
  final ValueNotifier<T> _valueNotifier;

  BaseHook(T initialState) : _valueNotifier = ValueNotifier<T>(initialState);

  T get state => _valueNotifier.value;

  set state(T newState) {
    if (_valueNotifier.value != newState) {
      _valueNotifier.value = newState;
    }
  }

  void addListener(VoidCallback listener) {
    _valueNotifier.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    _valueNotifier.removeListener(listener);
  }

  void reset(T initialState) {
    state = initialState;
  }

  void dispose() {
    _valueNotifier.dispose();
  }
}
