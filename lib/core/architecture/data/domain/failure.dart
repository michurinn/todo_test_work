
base class Failure<T extends Object?> implements Exception {
  /// Original error.
  final T original;

  /// Stack Trace.
  final StackTrace? trace;

  const Failure({
    required this.original,
    required this.trace,
  });
}
