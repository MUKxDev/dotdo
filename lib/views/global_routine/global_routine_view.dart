import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/long_Groutine_card/long_Groutine_card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/routine_task/routine_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'global_routine_view_model.dart';

class GlobalRoutineView extends StatelessWidget {
  final String gRoutineId;

  const GlobalRoutineView({Key key, this.gRoutineId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GlobalRoutineViewModel>.reactive(
      onModelReady: (GlobalRoutineViewModel viewModel) =>
          viewModel.handelStartup(gRoutineId),
      builder:
          (BuildContext context, GlobalRoutineViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Global Routine'),
            shape: appBarShapeBorder,
            actions: [
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.download,
                    color: viewModel.isAddedGRotine
                        ? (Theme.of(context).brightness == Brightness.light
                            ? AppColors.lightGreen
                            : AppColors.darkGreen)
                        : null,
                  ),
                  onPressed: () => viewModel.toggleIsAddedGRoutine()),
            ],
          ),
          body: SafeArea(
            child: viewModel.isBusy
                // CircularProgressIndicator
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: StreamBuilder(
                                  stream: viewModel.routineStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    Routine newRoutine;
                                    if (snapshot.hasData) {
                                      newRoutine =
                                          Routine.fromMap(snapshot.data.data());
                                      viewModel.updateRoutine(newRoutine);
                                    }

                                    return (snapshot.hasData == false ||
                                            snapshot.data.exists == false)
                                        ? Container()
                                        : LongGRoutineCardWidget(
                                            isLiked: viewModel.isLiked,
                                            routine: newRoutine,
                                            // onTap: () {=>
                                            //     viewModel.routineTapped(
                                            //         snapshot.data.id)},
                                            toggleLike: () =>
                                                viewModel.toggleIsLiked(),
                                          );
                                  },
                                ),
                              ),

                              // * RUTasks
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  child: SingleChildScrollView(
                                    child: StreamBuilder(
                                      stream: viewModel.tasksStream,
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        List<QueryDocumentSnapshot> taskList;
                                        if (snapshot.hasData) {
                                          taskList = snapshot.data.docs;

                                          taskList.sort((a, b) {
                                            int aInt =
                                                a.get('completed') == false
                                                    ? 0
                                                    : 1;
                                            int bInt =
                                                b.get('completed') == false
                                                    ? 0
                                                    : 1;
                                            return aInt.compareTo(bInt);
                                          });
                                        } else {
                                          taskList = [];
                                        }

                                        return (snapshot.hasData == false ||
                                                snapshot.data.size == 0)
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 40),
                                                child: Center(
                                                  child: DescriptionTextWidget(
                                                    description:
                                                        'There is no tasks for this routine.',
                                                  ),
                                                ),
                                              )
                                            : ListView.builder(
                                                key: UniqueKey(),
                                                itemCount: taskList.length,
                                                itemBuilder: (
                                                  BuildContext context,
                                                  int index,
                                                ) =>
                                                    Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0,
                                                      vertical: 10),
                                                  child: RoutineTaskWidget(
                                                    backgroundcolor: Theme.of(
                                                                    context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? AppColors.lightRoutine
                                                        : AppColors.darkRoutine,
                                                    task: Task.fromMap(
                                                        taskList[index].data()),

                                                    // onTap: () =>
                                                    //     viewModel.taskTapped(
                                                    //         taskList[index].id),
                                                    togglecompleted: () {},
                                                  ),
                                                ),
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                              );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
      viewModelBuilder: () => GlobalRoutineViewModel(),
    );
  }
}
