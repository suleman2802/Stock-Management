class Rows {
  final String id;
  final int noOfRows;
  Rows({String? id, required this.noOfRows})
      : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Rows copyWith({String? id, int? noOfRows}) {
    return Rows(id: id ?? this.id, noOfRows: noOfRows ?? this.noOfRows);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'noOfRows': noOfRows,
    };
  }

  factory Rows.fromMap(Map<String, dynamic> map) {
    return Rows(
      id: map['id'] as String,
      noOfRows: map['noOfRows'] as int,
    );
  }
}
