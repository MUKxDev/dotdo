import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'group_challenge_view_model.dart';

class GroupChallengeWidget extends StatelessWidget {
  final Function onTap;
  final String lable;
  final String groupName;
  final int rank;
  final ImageProvider<Object> image;

  const GroupChallengeWidget(
      {Key key,
      @required this.onTap,
      @required this.lable,
      @required this.groupName,
      @required this.rank,
      @required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GroupChallengeViewModel>.reactive(
      builder:
          (BuildContext context, GroupChallengeViewModel viewModel, Widget _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CardWidget(
            onTap: onTap,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LableTextWidget(lable: lable),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: image),
                    ),
                  ),
                  Center(
                    child: Text(groupName),
                  ),
                  DescriptionTextWidget(description: 'Rank: $rank'),
                ],
              ),
            ),
            height: 140,
            width: 216,
          ),
        );
      },
      viewModelBuilder: () => GroupChallengeViewModel(),
    );
  }
}
