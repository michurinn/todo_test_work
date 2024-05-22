/// {@template failure.class}
/// The base class for all failed operations
/// {@endtemplate}
base class Failure<T extends Object?> implements Exception {
  ///{@macro failure.class}
  const Failure({
    required this.original,
    required this.trace,
  });

  /// Original error.
  final T original;

  /// Stack Trace.
  final StackTrace? trace;
}
