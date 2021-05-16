import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Using a separate isLoggedInState state provider, called Pod for short.
final StateProvider<bool> isLoggedInPod =
    StateProvider<bool>((ProviderReference ref) {
  return false;
});

/// Using a separate showBonusTab state provider, called Pod for short.
final StateProvider<bool> showBonusTab =
    StateProvider<bool>((ProviderReference ref) {
  return false;
});
