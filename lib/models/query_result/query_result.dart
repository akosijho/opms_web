class QueryResult {
  final bool success;
  final String? errorMessage;
  final dynamic returnValue;
  QueryResult._({required this.success, this.errorMessage, this.returnValue});

  factory QueryResult.success({dynamic returnValue}) =>
      QueryResult._(success: true, returnValue: returnValue);

  factory QueryResult.error(String message) =>
      QueryResult._(success: false, errorMessage: message);
}
