import 'package:flutter/foundation.dart';

class BaseHook<T> {
  final ValueNotifier<T> _valueNotifier;
  bool _isDisposed = false;

  BaseHook(T initialState) : _valueNotifier = ValueNotifier<T>(initialState);

  T get state => _valueNotifier.value;

  set state(T newState) {
    if (_valueNotifier.value != newState && !_isDisposed) {
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
    if (_isDisposed) return;
    state = initialState;
  }

  void dispose() {
    _isDisposed = true;
    _valueNotifier.dispose();
  }
}
