/// Generic API envelope from backend.
class ApiResponse<T> {
  const ApiResponse({
    this.data,
    this.message,
    this.success = false,
  });

  final T? data;
  final String? message;
  final bool success;
}
