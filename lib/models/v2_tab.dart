import 'dart:convert';

class V2Tab {
  final String name;
  final String id;

  V2Tab({
    this.name,
    this.id,
  });

  @override
  String toString() {
    return jsonEncode({
      'name': name,
      'id': id,
    });
  }
}
