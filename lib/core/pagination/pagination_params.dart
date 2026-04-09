/// Request parameters for paged endpoints.
class PaginationParams {
  const PaginationParams({this.page = 1, this.limit = 20});

  final int page;
  final int limit;
}
