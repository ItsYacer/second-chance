import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testgit/layout/cubit/states.dart';
import 'package:testgit/shared/shared%20Perfoamance/cache_helper.dart';
import 'package:testgit/shared/sqlfilt.dart';
import '../../modules/archived_tasks_screen.dart';
import '../../modules/done_tasks_screen.dart';
import '../../modules/new_tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  final TextEditingController titleController = TextEditingController();

  final TextEditingController timeController = TextEditingController();

  final TextEditingController dateController = TextEditingController();


  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  SqlDb database = SqlDb();

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.insertDate(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")');
    emit(AppInsertDatabaseState());
    myData();
  }

  Future<List<Map>> getDataFromDatabase() async {
    return await database.readDate('SELECT * FROM tasks');
  }

  myData() {
    newTasks =[];
    doneTasks =[];
    archivedTasks =[];
    emit(AppGetDatabaseLoadingState());
    getDataFromDatabase().then((value) {
      for (var element in value) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      }
    });
    emit(AppGetDatabaseState());
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    await database
        .updateDate(''' UPDATE "tasks" SET 'status'= '$status' WHERE id = $id ''');
    emit(AppUpdateDatabaseState());
    myData();
  }

  void deleteData({
    required int id,
  }) async {
    await database.deleteDate(
      '''DELETE FROM "tasks" WHERE id = '$id' ''',
    );
    emit(AppDeleteDatabaseState());
    myData();
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    titleController.clear();
    timeController.clear();
    dateController.clear();
    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

void changeAppMode({bool? fromShared}) {
  if (fromShared != null) {
    isDark = fromShared;
    emit(AppChangeModeState());
  } else {
    isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeModeState());
    });
  }
}
@override
  Future<void> close() {
    // TODO: implement close
    titleController.dispose();
    timeController.dispose();
    dateController.dispose();

    return super.close();
  }
}

