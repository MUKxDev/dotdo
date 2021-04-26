import 'dart:convert';

class Pvp {
  final String userA;
  final String userB;
  final int aWinng;
  final int bWinning;
  final int draws;
  Pvp({
    this.userA,
    this.userB,
    this.aWinng,
    this.bWinning,
    this.draws,
  });

  Pvp copyWith({
    String userA,
    String userB,
    int aWinng,
    int bWinning,
    int draws,
  }) {
    return Pvp(
      userA: userA ?? this.userA,
      userB: userB ?? this.userB,
      aWinng: aWinng ?? this.aWinng,
      bWinning: bWinning ?? this.bWinning,
      draws: draws ?? this.draws,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userA': userA,
      'userB': userB,
      'aWinng': aWinng,
      'bWinning': bWinning,
      'draws': draws,
    };
  }

  factory Pvp.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Pvp(
      userA: map['userA'],
      userB: map['userB'],
      aWinng: map['aWinng'],
      bWinning: map['bWinning'],
      draws: map['draws'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Pvp.fromJson(String source) => Pvp.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Pvp(userA: $userA, userB: $userB, aWinng: $aWinng, bWinning: $bWinning, draws: $draws)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Pvp &&
        o.userA == userA &&
        o.userB == userB &&
        o.aWinng == aWinng &&
        o.bWinning == bWinning &&
        o.draws == draws;
  }

  @override
  int get hashCode {
    return userA.hashCode ^
        userB.hashCode ^
        aWinng.hashCode ^
        bWinning.hashCode ^
        draws.hashCode;
  }
}
