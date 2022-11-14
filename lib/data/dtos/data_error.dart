import 'dart:math';

class VirtualErr {
  List<Map<String, dynamic>> _item = [];

  static final VirtualErr _err = VirtualErr._privateConstructor();

  VirtualErr._privateConstructor();

  factory VirtualErr() {
    return _err;
  }

  Future<void> addErr(Map<String, dynamic> item) async {
    item["id"] = Random().nextInt(10);
    _item.add(item);
  }

  Future<void> removeErr(int id) async {
    _item.removeWhere((item) => item["id"] == id);
  }

  Future<List<Map<String, dynamic>>> list() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _item;
  }
}
