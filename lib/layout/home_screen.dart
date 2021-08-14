import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is HomeNewPostState)
          navigateTo(context, NewPostScreen());
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.notifications_none),
                onPressed: (){},
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)=> cubit.changeBottomNavBarItem(index),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat),label: 'chat'),
              BottomNavigationBarItem(icon: Icon(Icons.post_add),label: 'post'),
              BottomNavigationBarItem(icon: Icon(Icons.person_pin),label: 'users'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings'),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}


// ConditionalBuilder(
// condition: HomeCubit.get(context).model != null,
// builder: (context) {
// var model = HomeCubit.get(context).model;
// return Column(
// children: [
// if (!FirebaseAuth.instance.currentUser.emailVerified)
// Container(
// color: Colors.amber.withOpacity(.6),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20),
// child: Row(
// children: [
// Icon(Icons.info_outline),
// SizedBox(
// width: 10,
// ),
// Text('please verifay your email'),
// Spacer(),
// defaultTextButton(
// onPressed: () {
// FirebaseAuth.instance.currentUser
//     .sendEmailVerification()
//     .then((value) {
// showToast(msg: 'check your email', state: ToastState.SUCCESS);
// }).catchError((error) {
// print(error.toString());
// });
// },
// text: 'send',
// ),
// ],
// ),
// ),
// )
//
// ],
// );
// },
// fallback: (context) => Center(child: CircularProgressIndicator()),
// )
