import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'social_view_model.dart';
          
class SocialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SocialViewModel>.reactive(
      builder: (BuildContext context, SocialViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('Social View'),
          ),
        );
      },
      viewModelBuilder: () => SocialViewModel(),
    );
  }
}
