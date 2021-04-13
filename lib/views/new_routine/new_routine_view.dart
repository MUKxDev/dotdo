import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'new_routine_view_model.dart';
          
class NewRoutineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewRoutineViewModel>.reactive(
      builder: (BuildContext context, NewRoutineViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('NewRoutine View'),
          ),
        );
      },
      viewModelBuilder: () => NewRoutineViewModel(),
    );
  }
}
