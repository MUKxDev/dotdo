import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/smart_widgets/task/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'today_task_view_model.dart';

class TodayTaskWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodayTaskViewModel>.reactive(
      builder: (BuildContext context, TodayTaskViewModel viewModel, Widget _) {
        return AnimatedList(
          key: viewModel.globalKey,
          initialItemCount: viewModel.todayTaskList.length,
          itemBuilder: (BuildContext context, int index, Animation animation) =>
              SizeTransition(
            sizeFactor: animation,
            child: ScaleTransition(
              scale: animation,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Dismissible(
                  // key: UniqueKey(),
                  key: Key(viewModel.todayTaskList[index].id),
                  background: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.darkGreen,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Done!',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  secondaryBackground: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.darkGreen,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Done!',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    viewModel.toggleCheckedTask(
                        index, viewModel.todayTaskList[index]);
                  },
                  child: TaskWidget(
                      public: viewModel.todayTaskList[index].public,
                      checked: viewModel.todayTaskList[index].checked,
                      lable: viewModel.todayTaskList[index].lable,
                      due: viewModel.todayTaskList[index].due,
                      category: viewModel.todayTaskList[index].category,
                      onTap: () =>
                          viewModel.onTaskTap(viewModel.todayTaskList[index]),
                      toggleChecked: () => viewModel.toggleCheckedTask(
                          index, viewModel.todayTaskList[index]),
                      id: viewModel.todayTaskList[index].id),
                ),
              ),
            ),
          ),
          shrinkWrap: true,
          physics: ScrollPhysics(),
        );
      },
      viewModelBuilder: () => TodayTaskViewModel(),
    );
  }
}
