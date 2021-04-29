import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget {
  final User user;
  final Function onTap;
  final Color backgroundcolor;

  const UserCardWidget({
    Key key,
    this.user,
    this.onTap,
    this.backgroundcolor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardWidget(
        backgroundcolor: backgroundcolor,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LableTextWidget(lable: user.userName),
                  DescriptionTextWidget(
                      description: 'dots: ${user.dots.toString()}')
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 50,
                width: 50,
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(user.profilePic),
                ),
              ),
            ),
          ],
        ),
        // TODO: see if this works
        height: null,
        width: screenWidth(context));
  }
}
