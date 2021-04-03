import 'dart:convert';

class groups {
  final String name;
  final String picture;
  final int noOfmemeber;
  groups({
    this.name,
    this.picture,
    this.noOfmemeber,
  });

  groups copyWith({
    String name,
    String picture,
    int noOfmemeber,
  }) {
    return groups(
      name: name ?? this.name,
      picture: picture ?? this.picture,
      noOfmemeber: noOfmemeber ?? this.noOfmemeber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'picture': picture,
      'noOfmemeber': noOfmemeber,
    };
  }

  factory groups.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return groups(
      name: map['name'],
      picture: map['picture'],
      noOfmemeber: map['noOfmemeber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory groups.fromJson(String source) => groups.fromMap(json.decode(source));

  @override
  String toString() =>
      'groups(name: $name, picture: $picture, noOfmemeber: $noOfmemeber)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is groups &&
        o.name == name &&
        o.picture == picture &&
        o.noOfmemeber == noOfmemeber;
  }

  @override
  int get hashCode => name.hashCode ^ picture.hashCode ^ noOfmemeber.hashCode;
}
