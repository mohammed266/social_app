


import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';

class LoginCubit extends  Cubit<LoginStates>{

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  void userLogin({@required String email,@required String password,}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      emit(LoginSuccessState(value.user.uid));
      print(value.user.email);
      print(value.user.uid);
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  Icon suffix = Icon(Icons.visibility_outlined);
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined);
    emit(ChangePasswordVisibilityState());
  }
}