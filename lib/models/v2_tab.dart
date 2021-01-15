import 'dart:convert';

class V2Tab {
  final String name;
  final String id;

  final bool isFromNode;

  V2Tab({
    this.name,
    this.id,
    this.isFromNode = false,
  });

  @override
  String toString() {
    return jsonEncode({
      'name': name,
      'id': id,
      'isFromNode': isFromNode,
    });
  }
}
