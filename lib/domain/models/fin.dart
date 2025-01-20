class Fin {
  final String id;
  final int finSize;
  Fin({String? id, required this.finSize})
      : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Fin copyWith({String? id, int? finSize}) {
    return Fin(id: id ?? this.id, finSize: finSize ?? this.finSize);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'size': finSize,
    };
  }

  factory Fin.fromMap(Map<String, dynamic> map) {
    return Fin(
      id: map['id'] as String,
      finSize: map['size'] as int,
    );
  }
}
