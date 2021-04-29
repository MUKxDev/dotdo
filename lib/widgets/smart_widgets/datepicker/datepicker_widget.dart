import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/style.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'datepicker_view_model.dart';

class DatepickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DatepickerViewModel>.reactive(
      builder: (BuildContext context, DatepickerViewModel viewModel, Widget _) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: DatePicker(
              DateTime.now(),
              height: 102,
              initialSelectedDate: viewModel.currentDate,
              selectionColor: Theme.of(context).accentColor,
              selectedTextColor: Colors.white,
              dayTextStyle: defaultDayTextStyle.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              dateTextStyle: defaultDateTextStyle.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              monthTextStyle: defaultMonthTextStyle.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              onDateChange: (date) {
                // New date selected
                viewModel.updateSelectedValue(date: date);
              },
            ),
          ),
        );
      },
      viewModelBuilder: () => DatepickerViewModel(),
    );
  }
}
