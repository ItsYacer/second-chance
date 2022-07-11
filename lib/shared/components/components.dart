import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../../layout/cubit/cubit.dart';

Widget buildTaskItem(Map model, context) => Dismissible(
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${model['date']}',
                      style: Theme.of(context).textTheme.bodyText1
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'done',
                  id: model['id'],
                );
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'archive',
                  id: model['id'],
                );
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(
          id: model['id'],
        );
      },
    );

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Container(
      width: 1.0,
      color: Colors.black,
    );

Widget defaultTextField({
  required String label,
  required TextEditingController controller,
  required TextInputType type,
  bool obscureText = false,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  ValueChanged<String>? onFieldSubmitted,
  FormFieldValidator<String>? validator,
  required IconData prefixIcon,
  IconData? suffixIcon,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      decoration: InputDecoration(
        label: Text(label),
        prefix: Icon(prefixIcon),
        suffixIcon: Icon(suffixIcon),
      ),
    );
