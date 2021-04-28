import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/icon_button/icon_button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/user_card/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'search_view_model.dart';

class SearchView extends StatelessWidget {
  final String searchedText;

  const SearchView({Key key, this.searchedText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      onModelReady: (SearchViewModel viewModel) =>
          viewModel.handleOnStartUp(searchedText),
      builder: (BuildContext context, SearchViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Search'),
              shape: appBarShapeBorder,
            ),
            body: SingleChildScrollView(
              child: viewModel.isBusy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpaceXSmall(context),
                        // * Search Textfield
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, bottom: 10),
                                child: Container(
                                  height: 60,
                                  child: TextField(
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Search...',
                                      fillColor: Theme.of(context).primaryColor,
                                    ),
                                    controller: viewModel.searchController,
                                    onSubmitted: (searchValue) =>
                                        viewModel.search(searchValue),
                                  ),
                                ),
                              ),
                            ),
                            IconButtonWidget(
                                onTap: () {
                                  viewModel
                                      .search(viewModel.searchController.text);
                                },
                                iconData: FontAwesomeIcons.search)
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: HeaderTextWidget(lable: 'Users'),
                        ),
                        StreamBuilder(
                            stream: viewModel.usersStream,
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshots) {
                              List<QueryDocumentSnapshot> usersList = [];
                              if (snapshots.hasData) {
                                if (snapshots.data.size > 0) {
                                  usersList = snapshots.data.docs;
                                  usersList.removeWhere((element) =>
                                      element.id == viewModel.currentUserId);
                                }
                              }
                              return snapshots.hasData == false
                                  ? Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width: screenWidth(context),
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: DescriptionTextWidget(
                                              description: 'No users found'),
                                        ),
                                      ),
                                    )
                                  : (usersList.length == 0
                                      ? Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            width: screenWidth(context),
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: DescriptionTextWidget(
                                                  description:
                                                      'No users found'),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 200,
                                          child: ListView.builder(
                                              itemCount: usersList.length,
                                              itemBuilder: (context, index) {
                                                User _user = User.fromMap(
                                                    usersList[index].data());

                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 5,
                                                    horizontal: 10,
                                                  ),
                                                  child: UserCardWidget(
                                                    user: _user,
                                                    onTap: () =>
                                                        viewModel.userTapped(
                                                            usersList[index]
                                                                .id),
                                                  ),
                                                );
                                              }),
                                        ));
                            }),
                      ],
                    ),
            ),
          ),
        );
      },
      viewModelBuilder: () => SearchViewModel(),
    );
  }
}
