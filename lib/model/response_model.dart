class ResponseModel {
  ResponseModel({
    required this.data,
    required this.hasError,
    this.errorCode,
  required  this.status,
  });
  final String data;
  final bool status;
  final bool hasError;
  final int? errorCode;
}