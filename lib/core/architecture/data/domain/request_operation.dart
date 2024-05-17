
import 'package:todo_testwork/core/architecture/data/domain/failure.dart';
import 'package:todo_testwork/core/architecture/data/domain/result.dart';

/// Typedef for all methods that may fail.
/// These are mostly repository methods.
typedef RequestOperation<T> = Future<Result<T, Failure>>;
