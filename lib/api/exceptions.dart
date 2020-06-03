class UnexpectedResponseException implements Exception {
  final int expectedCode;
  final int resultCode;
  final Object responseBody;

  UnexpectedResponseException(this.expectedCode, this.resultCode,
      {this.responseBody = ''});

  @override
  String toString() =>
      'UnexpectedResponseException{ expectedCode: $expectedCode, resultCode: $resultCode, responseBody: "$responseBody" }';
}
