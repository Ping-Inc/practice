import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether the `public` lens is on screen. Keeps its tab around while you're
/// in it, even after you make the last public ping private.
final publicLensOpenProvider = StateProvider<bool>((ref) => false);
