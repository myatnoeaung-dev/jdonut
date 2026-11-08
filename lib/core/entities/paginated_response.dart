class PaginatedResponse<T> {
  final List<T>? data;
  final int? currentPage;
  final bool? hasNextPage;

  PaginatedResponse({this.data, this.currentPage, this.hasNextPage});
}
