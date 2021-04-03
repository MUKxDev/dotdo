import 'dart:convert';

class badges {
  final String picture;
  final String name;
  final String details;
  final int noOfFDone;
  badges({
    this.picture,
    this.name,
    this.details,
    this.noOfFDone,
  });

  badges copyWith({
    String picture,
    String name,
    String details,
    int noOfFDone,
  }) {
    return badges(
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

  factory badges.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return badges(
      picture: map['picture'],
      name: map['name'],
      details: map['details'],
      noOfFDone: map['noOfFDone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory badges.fromJson(String source) => badges.fromMap(json.decode(source));

  @override
  String toString() {
    return 'badges(picture: $picture, name: $name, details: $details, noOfFDone: $noOfFDone)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is badges &&
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
