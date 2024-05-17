/// {@template converter.class}
/// Base class for converters.
/// {@endtemplate}
abstract base class Converter<TResult, TFrom> {
  /// {@macro converter.class}
  const Converter();

  /// Convert TFrom to TResult.
  TResult convert(TFrom input);

  /// Convert nullable TFrom to nullable TResult.
  TResult? convertNullable(TFrom? input) => input == null ? null : convert(input);

  /// Convert TFrom list to TResult list.
  Iterable<TResult> convertMultiple(Iterable<TFrom> inputList) => inputList.map(convert);
}