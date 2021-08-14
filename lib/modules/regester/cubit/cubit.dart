import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {@required String email,
      @required String password,
      @required String name,
      @required String phone}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uid: value.user.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    @required String email,
    @required String uid,
    @required String name,
    @required String phone,
  }) {
    UserModel model = UserModel(
      phone: phone,
      email: email,
      name: name,
      uId: uid,
      bio : 'wite your bio',
      image: 'https://image.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg',
      cover: 'https://image.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg',
      isVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }

  Icon suffix = Icon(Icons.visibility_outlined);
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icon(Icons.visibility_outlined)
        : Icon(Icons.visibility_off_outlined);
    emit(RegisterChangePasswordVisibilityState());
  }
}
