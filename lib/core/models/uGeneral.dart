import 'dart:convert';

class UGeneral {
  final int noOfFollowers;
  final int noOfFollowing;
  final int noOfGroups;
  final int noOfBadges;
  final int noOfTaskCompleted;
  final int noOfChallangeCompleted;
  final int noOfLikes;
  final String lastBadge;
  UGeneral({
    this.noOfFollowers,
    this.noOfFollowing,
    this.noOfGroups,
    this.noOfBadges,
    this.noOfTaskCompleted,
    this.noOfChallangeCompleted,
    this.noOfLikes,
    this.lastBadge,
  });

  UGeneral copyWith({
    int noOfFollowers,
    int noOfFollowing,
    int noOfGroups,
    int noOfBadges,
    int noOfTaskCompleted,
    int noOfChallangeCompleted,
    int noOfLikes,
    String lastBadge,
  }) {
    return UGeneral(
      noOfFollowers: noOfFollowers ?? this.noOfFollowers,
      noOfFollowing: noOfFollowing ?? this.noOfFollowing,
      noOfGroups: noOfGroups ?? this.noOfGroups,
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
      'noOfGroups': noOfGroups,
      'noOfBadges': noOfBadges,
      'noOfTaskCompleted': noOfTaskCompleted,
      'noOfChallangeCompleted': noOfChallangeCompleted,
      'noOfLikes': noOfLikes,
      'lastBadge': lastBadge,
    };
  }

  factory UGeneral.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UGeneral(
      noOfFollowers: map['noOfFollowers'],
      noOfFollowing: map['noOfFollowing'],
      noOfGroups: map['noOfGroups'],
      noOfBadges: map['noOfBadges'],
      noOfTaskCompleted: map['noOfTaskCompleted'],
      noOfChallangeCompleted: map['noOfChallangeCompleted'],
      noOfLikes: map['noOfLikes'],
      lastBadge: map['lastBadge'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UGeneral.fromJson(String source) =>
      UGeneral.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UGeneral(noOfFollowers: $noOfFollowers, noOfFollowing: $noOfFollowing, noOfGroups: $noOfGroups, noOfBadges: $noOfBadges, noOfTaskCompleted: $noOfTaskCompleted, noOfChallangeCompleted: $noOfChallangeCompleted, noOfLikes: $noOfLikes, lastBadge: $lastBadge)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UGeneral &&
        o.noOfFollowers == noOfFollowers &&
        o.noOfFollowing == noOfFollowing &&
        o.noOfGroups == noOfGroups &&
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
        noOfGroups.hashCode ^
        noOfBadges.hashCode ^
        noOfTaskCompleted.hashCode ^
        noOfChallangeCompleted.hashCode ^
        noOfLikes.hashCode ^
        lastBadge.hashCode;
  }
}
