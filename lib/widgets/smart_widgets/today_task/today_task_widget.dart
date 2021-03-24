// import 'package:dotdo/theme/colors.dart';
// import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
// import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
// import 'package:dotdo/widgets/smart_widgets/task/task_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'today_task_view_model.dart';

// class TodayTaskWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<TodayTaskViewModel>.reactive(
//       builder: (BuildContext context, TodayTaskViewModel viewModel, Widget _) {
//         return viewModel.todayTaskList.length == 0
//             ? Padding(
//                 padding: const EdgeInsets.only(top: 40),
//                 child: Center(
//                   child: DateTime(
//                               viewModel.currentDate.year,
//                               viewModel.currentDate.month,
//                               viewModel.currentDate.day) ==
//                           DateTime(DateTime.now().year, DateTime.now().month,
//                               DateTime.now().day)
//                       ? DescriptionTextWidget(
//                           description: 'You don\'t have any tasks for today.',
//                         )
//                       : DescriptionTextWidget(
//                           description:
//                               'You don\'t have any tasks for ${viewModel.dateFormat.format(viewModel.currentDate)}.',
//                         ),
//                 ),
//               )
//             : ListView.builder(
//                 key: UniqueKey(),
//                 itemCount: viewModel.todayTaskList.length,
//                 itemBuilder: (
//                   BuildContext context,
//                   int index,
//                 ) =>
//                     Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   child: Dismissible(
//                     // key: UniqueKey(),
//                     key: Key(viewModel.todayTaskList[index].id),
//                     background: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color:
//                               Theme.of(context).brightness == Brightness.light
//                                   ? AppColors.lightGreen
//                                   : AppColors.darkGreen,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               LableTextWidget(
//                                 lable: 'Done!',
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     secondaryBackground: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color:
//                               Theme.of(context).brightness == Brightness.light
//                                   ? AppColors.lightGreen
//                                   : AppColors.darkGreen,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               LableTextWidget(
//                                 lable: 'Done!',
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     direction: DismissDirection.horizontal,
//                     onDismissed: (direction) {
//                       viewModel.toggleCheckedTask(
//                           index, viewModel.todayTaskList[index]);
//                     },
//                     child: TaskWidget(
//                         public: viewModel.todayTaskList[index].public,
//                         checked: viewModel.todayTaskList[index].checked,
//                         lable: viewModel.todayTaskList[index].lable,
//                         due: viewModel.todayTaskList[index].due,
//                         category: viewModel.todayTaskList[index].category,
//                         onTap: () =>
//                             viewModel.onTaskTap(viewModel.todayTaskList[index]),
//                         toggleChecked: () => viewModel.toggleCheckedTask(
//                             index, viewModel.todayTaskList[index]),
//                         id: viewModel.todayTaskList[index].id),
//                   ),
//                 ),
//                 shrinkWrap: true,
//                 physics: ScrollPhysics(),
//               );
//       },
//       viewModelBuilder: () => TodayTaskViewModel(),
//     );
//   }
// }
