import 'package:equatable/equatable.dart';

class DropDownModel<T> extends Equatable {
  final String id;
  final T? data;
  final T mainText;

  const DropDownModel({
    required this.id,
    this.data,
    required this.mainText,
  });

  bool get hasData => data != null;

  static List<DropDownModel<T>> createDropDownModels<T>({Map<T, T>? items}) {
    List<DropDownModel<T>> list = [];
    if (items == null || items.isEmpty) return const [];
    int i = 0;
    items.forEach((key, value) {
      list.add(
        DropDownModel(id: i.toString(), data: key, mainText: value)
      );
      i++;
    });
    return list;
  }

  static List<T> getListData<T>({List<DropDownModel<T>>? items}) {
    if (items == null || items.isEmpty) return const [];
    List<T> datas = [];
    for (var element in items) {
      if (element.hasData) {
        datas.add(element.mainText);
      }
    }
    return datas;
  }

  @override
  List<Object?> get props => [
    id,
    data.hashCode,
  ];
}
