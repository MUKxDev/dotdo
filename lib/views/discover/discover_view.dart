import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'discover_view_model.dart';

class DiscoverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiscoverViewModel>.reactive(
      builder: (BuildContext context, DiscoverViewModel viewModel, Widget _) {
        return Center(
          child: Text('Discover View'),
        );
      },
      viewModelBuilder: () => DiscoverViewModel(),
    );
  }
}
