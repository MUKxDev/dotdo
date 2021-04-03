import 'dart:convert';

class uGeneral {
  final int noOfFollowers;
  final int noOfFollowing;
  final int noOfBadges;
  final int noOfTaskCompleted;
  final int noOfChallangeCompleted;
  final int noOfLikes;
  final String lastBadge;
  uGeneral({
    this.noOfFollowers,
    this.noOfFollowing,
    this.noOfBadges,
    this.noOfTaskCompleted,
    this.noOfChallangeCompleted,
    this.noOfLikes,
    this.lastBadge,
  });

  uGeneral copyWith({
    int noOfFollowers,
    int noOfFollowing,
    int noOfBadges,
    int noOfTaskCompleted,
    int noOfChallangeCompleted,
    int noOfLikes,
    String lastBadge,
  }) {
    return uGeneral(
      noOfFollowers: noOfFollowers ?? this.noOfFollowers,
      noOfFollowing: noOfFollowing ?? this.noOfFollowing,
      noOfBadges: noOfBadges ?? this.noOfBadges,
      noOfTaskCompleted: noOfTaskCompleted ?? this.noOfTaskCompleted,
      noOfChallangeCompleted:
          noOfChallangeCompleted ?? this.noOfChallangeCompleted,
      noOfLikes: noOfLikes ?? this.noOfLikes,
      lastBadge: lastBadge ?? this.lastBadge,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'noOfFollowers': noOfFollowers,
      'noOfFollowing': noOfFollowing,
      'noOfBadges': noOfBadges,
      'noOfTaskCompleted': noOfTaskCompleted,
      'noOfChallangeCompleted': noOfChallangeCompleted,
      'noOfLikes': noOfLikes,
      'lastBadge': lastBadge,
    };
  }

  factory uGeneral.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return uGeneral(
      noOfFollowers: map['noOfFollowers'],
      noOfFollowing: map['noOfFollowing'],
      noOfBadges: map['noOfBadges'],
      noOfTaskCompleted: map['noOfTaskCompleted'],
      noOfChallangeCompleted: map['noOfChallangeCompleted'],
      noOfLikes: map['noOfLikes'],
      lastBadge: map['lastBadge'],
    );
  }

  String toJson() => json.encode(toMap());

  factory uGeneral.fromJson(String source) =>
      uGeneral.fromMap(json.decode(source));

  @override
  String toString() {
    return 'uGeneral(noOfFollowers: $noOfFollowers, noOfFollowing: $noOfFollowing, noOfBadges: $noOfBadges, noOfTaskCompleted: $noOfTaskCompleted, noOfChallangeCompleted: $noOfChallangeCompleted, noOfLikes: $noOfLikes, lastBadge: $lastBadge)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is uGeneral &&
        o.noOfFollowers == noOfFollowers &&
        o.noOfFollowing == noOfFollowing &&
        o.noOfBadges == noOfBadges &&
        o.noOfTaskCompleted == noOfTaskCompleted &&
        o.noOfChallangeCompleted == noOfChallangeCompleted &&
        o.noOfLikes == noOfLikes &&
        o.lastBadge == lastBadge;
  }

  @override
  int get hashCode {
    return noOfFollowers.hashCode ^
        noOfFollowing.hashCode ^
        noOfBadges.hashCode ^
        noOfTaskCompleted.hashCode ^
        noOfChallangeCompleted.hashCode ^
        noOfLikes.hashCode ^
        lastBadge.hashCode;
  }
}
