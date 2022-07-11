import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testgit/shared/components/components.dart';
import 'package:testgit/layout/cubit/cubit.dart';

import 'cubit/states.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is AppInsertDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: Theme.of(context).textTheme.subtitle1,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.changeAppMode();
                  },
                  icon: const Icon(Icons.dark_mode))
            ],
          ),
          body: ConditionalBuilder(
            condition: state is !AppGetDatabaseLoadingState,
            builder: (context) => cubit.screens[cubit.currentIndex],
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDatabase(
                    title: cubit.titleController.text,
                    time: cubit.timeController.text,
                    date: cubit.dateController.text,
                  );
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => Container(
                        padding: const EdgeInsets.all(
                          20.0,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultTextField(
                                controller: cubit.titleController,
                                type: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'title must not be empty';
                                  }
                                  return null;
                                },
                                label: 'Task Title',
                                prefixIcon: Icons.title,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              defaultTextField(
                                controller: cubit.timeController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    cubit.timeController.text =
                                        value!.format(context).toString();
                                    // debugPrint(value.format(context));
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'time must not be empty';
                                  }

                                  return null;
                                },
                                label: 'Task Time',
                                prefixIcon: Icons.watch_later_outlined,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              defaultTextField(
                                controller: cubit.dateController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2200-05-03'),
                                  ).then((value) {
                                    cubit.dateController.text = DateFormat('yyyy-MM-dd').format(value as DateTime);

                                  }).catchError((error) {
                                    print(error.toString());
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'date must not be empty';
                                  }

                                  return null;
                                },
                                label: 'Task Date',
                                prefixIcon: Icons.calendar_today,
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20.0,
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomSheetState(
                    isShow: false,
                    icon: Icons.edit,
                  );
                });
                cubit.changeBottomSheetState(
                  isShow: true,
                  icon: Icons.add,
                );
              }
            },
            child: Icon(
              cubit.fabIcon,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                ),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle_outline,
                ),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive_outlined,
                ),
                label: 'Archived',
              ),
            ],
          ),
        );
      },
    );
  }
}
