import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/inactive_challenge_card/inactive_challenge_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'likes_view_model.dart';

class LikesView extends StatelessWidget {
  final String userId;

  const LikesView({Key key, this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LikesViewModel>.reactive(
      onModelReady: (LikesViewModel viewModel) =>
          viewModel.handleOnStartUp(userId),
      builder: (BuildContext context, LikesViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Likes'),
            shape: appBarShapeBorder,
          ),
          body: viewModel.isbusy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // * Liked routiens header
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: HeaderTextWidget(lable: 'Liked routiens'),
                      ),
                      //  * Liked public routiens Stream
                      ((viewModel.routinesList.length == 0
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: screenWidth(context),
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: DescriptionTextWidget(
                                      description: 'No liked routines'),
                                ),
                              ),
                            )
                          : Container(
                              height: 110,
                              child: ListView.builder(
                                clipBehavior: Clip.hardEdge,
                                scrollDirection: Axis.horizontal,
                                itemCount: viewModel.routinesList.length,
                                itemBuilder: (context, index) {
                                  Routine _routine =
                                      viewModel.routinesList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: _routine == null
                                        ? Container()
                                        : InactiveChallengeCardWidget(
                                            backgroundcolor:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppColors.lightRoutine
                                                    : AppColors.darkRoutine,
                                            public: _routine.publicRoutine,
                                            iconData: _routine.iconData,
                                            iconColor: _routine.iconColor,
                                            lable: _routine.name,
                                            likes: _routine.noOfLikes,
                                            onTap: () => viewModel
                                                .routineTapped(viewModel
                                                    .routinesIdList[index]),
                                          ),
                                  );
                                },
                              ),
                            ))),
                    ],
                  ),
                ),
        );
      },
      viewModelBuilder: () => LikesViewModel(),
    );
  }
}
