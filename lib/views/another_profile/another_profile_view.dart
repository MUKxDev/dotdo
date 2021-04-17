import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'another_profile_view_model.dart';

class AnotherProfileView extends StatelessWidget {
  final String uid;

  const AnotherProfileView({Key key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AnotherProfileViewModel>.reactive(
      builder:
          (BuildContext context, AnotherProfileViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            shape: appBarShapeBorder,
          ),
          body: ProfileView(
            uid: uid,
          ),
        );
      },
      viewModelBuilder: () => AnotherProfileViewModel(),
    );
  }
}
