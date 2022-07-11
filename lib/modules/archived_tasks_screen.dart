import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testgit/shared/components/components.dart';
import 'package:testgit/layout/cubit/cubit.dart';

import '../layout/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget
{
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var tasks = AppCubit.get(context).archivedTasks;

        return tasksBuilder(
          tasks: tasks,
        );
      },
    );
  }
}