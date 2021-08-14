import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/shared/components/constants.dart';

import 'modules/login/login_screen.dart';
import 'network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await  FirebaseMessaging().getToken();

 FirebaseMessaging firebaseMessaging = FirebaseMessaging();

 firebaseMessaging.configure(
   // onBackgroundMessage: ,
   // onLaunch: ,
   // onMessage: ,
   // onResume: ,
 );
  print(token);
  await CacheHelper.init();

  Widget widget;

  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LoginScreen();
  }

  runApp(
    MyApp(
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final startWidget;

  const MyApp({Key key, this.startWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeCubit()
            ..getUserData()
            ..getLikePosts()
              ..getUsers(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            textTheme: TextTheme(
              headline6: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0.0,
            actionsIconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            // selectedItemColor: defaultColor,
            elevation: 20,
          ),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: startWidget,
        // LoginScreen(),
      ),
    );
  }
}
