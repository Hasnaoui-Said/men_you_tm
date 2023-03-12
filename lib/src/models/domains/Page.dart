class Page<T> {
  final int number;
  final int size;
  final int totalPages;
  final List<T> content;

  Page({required this.number, required this.size, required this.totalPages, required this.content});

  // factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson<T>(json);
  //
  // Map<String, dynamic> toJson() => _$PageToJson<T>(this);
}