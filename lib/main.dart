import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:testgit/layout/cubit/cubit.dart';
import 'package:testgit/shared/bloc_observer.dart';
import 'package:testgit/shared/shared%20Perfoamance/cache_helper.dart';
import 'package:testgit/shared/styles/theme.dart';
import 'package:testgit/layout/todo_layout.dart';

import 'layout/cubit/states.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getDate(key: 'isDark');
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(
        isDark: isDark ?? false,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.isDark}) : super(key: key);
  bool? isDark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..myData()
        ..changeAppMode(
          fromShared: isDark,
        ),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}
