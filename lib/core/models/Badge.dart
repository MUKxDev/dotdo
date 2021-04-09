import 'dart:convert';

class Badge {
  final String picture;
  final String name;
  final String details;
  final int noOfFDone;
  Badge({
    this.picture,
    this.name,
    this.details,
    this.noOfFDone,
  });

  Badge copyWith({
    String picture,
    String name,
    String details,
    int noOfFDone,
  }) {
    return Badge(
      picture: picture ?? this.picture,
      name: name ?? this.name,
      details: details ?? this.details,
      noOfFDone: noOfFDone ?? this.noOfFDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'picture': picture,
      'name': name,
      'details': details,
      'noOfFDone': noOfFDone,
    };
  }

  factory Badge.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Badge(
      picture: map['picture'],
      name: map['name'],
      details: map['details'],
      noOfFDone: map['noOfFDone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Badge.fromJson(String source) => Badge.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Badge(picture: $picture, name: $name, details: $details, noOfFDone: $noOfFDone)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Badge &&
        o.picture == picture &&
        o.name == name &&
        o.details == details &&
        o.noOfFDone == noOfFDone;
  }

  @override
  int get hashCode {
    return picture.hashCode ^
        name.hashCode ^
        details.hashCode ^
        noOfFDone.hashCode;
  }
}
