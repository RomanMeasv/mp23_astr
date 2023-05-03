import 'package:get/get.dart';

class RxItemModel {
  final id = 0.obs;
  final nome = 'nome'.obs;
}

class ItemModel {
  ItemModel({id, nome});

  final rx = RxItemModel();

  get nome => rx.nome.value;
  set nome(value) => rx.nome.value = value;

  get id => rx.id.value;
  set id(value) => rx.id.value = value;

  ItemModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    return data;
  }
}