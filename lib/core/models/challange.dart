// import 'dart:convert';

// import 'package:flutter/material.dart';

// class Challange {
//   final bool public;
//   final IconData iconData;
//   final Color iconColor;
//   final String lable;
//   final String description;
//   final double progressValue;
//   Challange({
//     this.public,
//     this.iconData,
//     this.iconColor,
//     this.lable,
//     this.description,
//     this.progressValue,
//   });
//   // final Function onTap;

//   Challange copyWith({
//     bool public,
//     IconData iconData,
//     Color iconColor,
//     String lable,
//     String description,
//     double progressValue,
//   }) {
//     return Challange(
//       public: public ?? this.public,
//       iconData: iconData ?? this.iconData,
//       iconColor: iconColor ?? this.iconColor,
//       lable: lable ?? this.lable,
//       description: description ?? this.description,
//       progressValue: progressValue ?? this.progressValue,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'public': public,
//       'iconData': iconData?.codePoint,
//       'iconColor': iconColor?.value,
//       'lable': lable,
//       'description': description,
//       'progressValue': progressValue,
//     };
//   }

//   factory Challange.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Challange(
//       public: map['public'],
//       iconData: IconData(map['iconData'], fontFamily: 'MaterialIcons'),
//       iconColor: Color(map['iconColor']),
//       lable: map['lable'],
//       description: map['description'],
//       progressValue: map['progressValue'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Challange.fromJson(String source) =>
//       Challange.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Challange(public: $public, iconData: $iconData, iconColor: $iconColor, lable: $lable, description: $description, progressValue: $progressValue)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is Challange &&
//         o.public == public &&
//         o.iconData == iconData &&
//         o.iconColor == iconColor &&
//         o.lable == lable &&
//         o.description == description &&
//         o.progressValue == progressValue;
//   }

//   @override
//   int get hashCode {
//     return public.hashCode ^
//         iconData.hashCode ^
//         iconColor.hashCode ^
//         lable.hashCode ^
//         description.hashCode ^
//         progressValue.hashCode;
//   }
// }
