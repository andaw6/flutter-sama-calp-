class Pagination {
  final int currentPage;
  final int totalPages;
  final int perPage;
  final int totalItems;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
    required this.totalItems,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['lastPage'],
      perPage: json['perPage'],
      totalItems: json['totalCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'lastPage': totalPages,
      'perPage': perPage,
      'totalCount': totalItems,
    };
  }
}
