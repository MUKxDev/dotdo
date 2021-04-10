import 'dart:convert';

class User {
  final String email;
  final String userName;
  final int dots;
  final String profilePic;
  User({
    this.email,
    this.userName,
    this.dots,
    this.profilePic,
  });

  User copyWith({
    String email,
    String userName,
    int dots,
    String profilePic,
  }) {
    return User(
      email: email ?? this.email,
      userName: userName ?? this.userName,
      dots: dots ?? this.dots,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userName': userName,
      'dots': dots,
      'profilePic': profilePic,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      email: map['email'],
      userName: map['userName'],
      dots: map['dots'],
      profilePic: map['profilePic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(email: $email, userName: $userName, dots: $dots, profilePic: $profilePic)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.email == email &&
        o.userName == userName &&
        o.dots == dots &&
        o.profilePic == profilePic;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        userName.hashCode ^
        dots.hashCode ^
        profilePic.hashCode;
  }
}
