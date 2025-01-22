class Company {
  final String id;
  final String name;
  Company({String? id, required this.name})
      : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Company copyWith({String? id, String? name}) {
    return Company(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
