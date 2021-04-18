import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'pvp_challenge_details_view_model.dart';

class PvpChallengeDetailsView extends StatelessWidget {
  final Map args;

  const PvpChallengeDetailsView({Key key, this.args}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PvpChallengeDetailsViewModel>.reactive(
      onModelReady: (PvpChallengeDetailsViewModel viewModel) =>
          viewModel.handelStartup(args),
      builder: (BuildContext context, PvpChallengeDetailsViewModel viewModel,
          Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('PvpChallengeDetails View'),
          ),
        );
      },
      viewModelBuilder: () => PvpChallengeDetailsViewModel(),
    );
  }
}
