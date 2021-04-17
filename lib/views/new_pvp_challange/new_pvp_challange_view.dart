import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'new_pvp_challange_view_model.dart';
          
class NewPvpChallangeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewPvpChallangeViewModel>.reactive(
      builder: (BuildContext context, NewPvpChallangeViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('NewPvpChallange View'),
          ),
        );
      },
      viewModelBuilder: () => NewPvpChallangeViewModel(),
    );
  }
}
