class ResponseModel {
  ResponseModel({
    required this.data,
    required this.hasError,
    this.errorCode,
    this.status,
  });
  final String data;
  final String? status;
  final bool hasError;
  final int? errorCode;
}