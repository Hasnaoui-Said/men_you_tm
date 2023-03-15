
class MenuItemsDetail {
  String idMenuItem;
  int count;

  MenuItemsDetail({required this.idMenuItem, required this.count});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMenuItem'] = idMenuItem;
    data['count'] = count;
    return data;
  }
  @override
  String toString() {
    return 'MenuItemsDetail{idMenuItem: $idMenuItem, count: $count}';
  }
}