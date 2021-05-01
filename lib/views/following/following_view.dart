import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/user_card/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'following_view_model.dart';

class FollowingView extends StatelessWidget {
  final String userID;

  const FollowingView({Key key, this.userID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FollowingViewModel>.reactive(
      onModelReady: (FollowingViewModel viewModel) =>
          viewModel.handleOnStartUp(userID),
      builder: (BuildContext context, FollowingViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Following'),
            shape: appBarShapeBorder,
          ),
          body: viewModel.isBusy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : viewModel.usersList.length == 0
                  ? Center(
                      child: DescriptionTextWidget(
                          description: 'There is no users'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpaceXSmall(context),
                          //  * users List
                          ((Container(
                            // height: 110,
                            child: ListView.builder(
                              shrinkWrap: true,
                              clipBehavior: Clip.hardEdge,
                              scrollDirection: Axis.vertical,
                              itemCount: viewModel.usersList.length,
                              itemBuilder: (context, index) {
                                User _user = viewModel.usersList[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: _user == null
                                      ? Container()
                                      : UserCardWidget(
                                          user: _user,
                                          onTap: () => viewModel.userTapped(
                                              viewModel.usersIdList[index]),
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
      viewModelBuilder: () => FollowingViewModel(),
    );
  }
}
